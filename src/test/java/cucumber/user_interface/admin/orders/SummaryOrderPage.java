package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class SummaryOrderPage {
    /**
     * Search
     */

    public static Target FULFILLMENT_SEARCH_TEXTBOX = Target.the("Fulfillment search textbox")
            .located(By.xpath("//div[contains(@class,'search-bar')]//div[contains(@class,'fulfillment-state')]"));

    public static Target ft_ORDER_NUMBER = Target.the("Order Number filter")
            .located(By.xpath("//div[@data-field='q[number]']//input"));

    public static Target ft_FULFILLMENT_STATE = Target.the("Fulfillment state filter")
            .located(By.xpath("//div[@data-field='q[fulfillment_states]']/div/div/div/div/div[2]"));

    public static Target PENDING_STATE = Target.the("Pending State")
            .located(By.xpath("div.popper-fulfillment-state-select .el-select-dropdown__item:nth-child(1)"));

    public static Target IN_PROGRESS_STATE = Target.the("In Progress State")
            .located(By.xpath("div.popper-fulfillment-state-select .el-select-dropdown__item:nth-child(2)"));

    public static Target FULFILLED_STATE = Target.the("Fulfilled State")
            .located(By.xpath("div.popper-fulfillment-state-select .el-select-dropdown__item:nth-child(3)"));

    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.cssSelector("button.search"));

    public static Target ORDER_TOP = Target.the("The Top of Order")
            .located(By.cssSelector("tr.order.top"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target FULFILLED_CHECKBOX = Target.the("The fulfilled checkbox")
            .located(By.cssSelector("table.summary .p-0.tc label.el-checkbox"));

    public static Target ORDER_NUMBER_LINK = Target.the("The order link")
            .located(By.cssSelector("table.summary .order-number a"));

    public static Target ft_STORES = Target.the("Stores")
            .located(By.xpath("//div[@data-field='q[store_ids]']//div[@multiple=\"multiple\"]/div/div[1]/input"));

    public static Target FIRST_STORE_FROM_SUGGESTION = Target.the("First store from suggestion")
            .located(By.cssSelector("div.popper-store-select ul li:nth-child(1)"));

    public static Target ft_SKU = Target.the("SKUs")
            .located(By.xpath("//div[@data-field='q[product_variant_ids]']//input"));

    public static Target FIRST_SKU_FROM_SUGGESTION = Target.the("First sku from suggestion")
            .located(By.cssSelector("div.popper-product-variant-select ul li:nth-child(1)"));

    public static Target ft_ROUTE_NAME = Target.the("Route Name field")
            .located(By.xpath("//div[@data-field='q[route_id]']//input"));

    public static Target FIRST_ROUTE_NAME_ON_SUGGESTION = Target.the("First route name on suggestion")
            .located(By.cssSelector("div.popper-route-select ul li:nth-child(3)"));

    public static Target UNASSIGNED_ROUTE = Target.the("Unassigned route")
            .located(By.cssSelector("div.popper-route-select ul li:nth-child(2)"));

    public static Target ft_TEMPERATURE_FIELD = Target.the("Temperature field")
            .located(By.xpath("//div[@data-field=\"q[temperature_name]\"]//input"));

    public static Target PAYMENT_STATUS = Target.the("PAYMENT_STATUS")
            .located(By.xpath("//div[@class='status-tag']"));

    public static Target SMALL_ORDER_SURCHARGE = Target.the("small order surcharge")
            .located(By.xpath("//span[contains(@class,'small-order-surcharge')]//strong"));

    public static Target LOGISTIC_SURCHARGE = Target.the("logistic surcharge")
            .located(By.xpath("//span[contains(@class,'logistics-surcharge')]//strong"));

    public static Target NOTIFICATION_BADGE = Target.the("Notification badge")
            .located(By.xpath("//div[contains(@class,'notification ')]//span"));


    public static Target FULFILLMENT_DATE = Target.the("fulfillment-date")
            .located(By.xpath("//div[@class='fulfillment-date']//strong"));

    public static Target BUYER_PAYMENT = Target.the("Buyer payment")
            .located(By.xpath("//div[contains(@class,'buyer-payment')]/strong"));


    public static Target DAYS_TO_FULFILL = Target.the("DAYS_TO_FULFILL")
            .located(By.xpath("//div[contains(@class,'days-to-fulfill')]//strong"));

    public static Target SUB_INVOICE = Target.the("Sub invoice")
            .located(By.xpath("//span[contains(text(),'Invoice')]/following-sibling::strong"));

    public static Target FULFILLMENT_STATUS(int i) {
        return Target.the("Fulfillment status")
                .located(By.xpath("(//dt[text()='Fulfillment status:']/following-sibling::dd/div)[" + i + "]"));
    }

    public static Target FULFILLMENT_STATUS(String subInvoice) {
        return Target.the("Fulfillment status of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span//div[@class='status-tag']"));
    }

    public static Target MARK_FULFILL_BUTTON(int i) {
        return Target.the("Mark fulfill button")
                .located(By.xpath("(//td[@class='tr' and @colspan='100%'])[" + i + "]//button[contains(@class,'has-tooltip')]"));
    }

    public static Target PO_ID(int i) {
        return Target.the("PO_ID")
                .located(By.xpath("(//span[@class='purchase-order']//strong)[" + i + "]"));
    }

    public static Target PO_ID = Target.the("PO_ID")
            .located(By.xpath("(//span[@class='purchase-order']//span[contains(text(),'PO_')])"));

    public static Target PO_ID(String subInvoice) {
        return Target.the("PO_ID of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span/button//strong"));
    }

    public static Target TOTAL_DELIVERY(int i) {
        return Target.the("TOTAL_DELIVERY")
                .located(By.xpath("(//dd[@class='total-delivery'])[" + i + "]"));
    }

    public static Target TOTAL_DELIVERY(String subInvoice) {
        return Target.the("TOTAL_DELIVERY of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span//dd[@class='total-delivery']"));
    }

    public static Target TOTAL_PAYMENT(int i) {
        return Target.the("total-payment")
                .located(By.xpath("(//dd[@class='total-payment'])[" + i + "]"));
    }

    public static Target TOTAL_PAYMENT(String subInvoice) {
        return Target.the("Total payment of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span//dd[@class='total-payment']"));
    }

    public static Target TOTAL_SERVICE(int i) {
        return Target.the("-total-service")
                .located(By.xpath("(//dd[@class='total-service'])[" + i + "]"));
    }

    public static Target TOTAL_SERVICE(String subInvoice) {
        return Target.the("Total service of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span//dd[@class='total-service']"));
    }

    public static Target TOTAL_WEIGHT(int i) {
        return Target.the("//dd[@class='total-weight']")
                .located(By.xpath("(//dd[@class='total-weight'])[" + i + "]"));
    }

    public static Target TOTAL_WEIGHT(String subInvoice) {
        return Target.the("Total weight of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/parent::a/following-sibling::span//dd[@class='total-weight']"));
    }

    public static Target ETA(int i) {
        return Target.the("Eta of subinvoice " + i)
                .located(By.xpath("(//div[@class='eta'])[" + i + "]"));
    }

    public static Target ETA(String subInvoice) {
        return Target.the("Eta of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::td/following-sibling::td/div[@class='eta']/span"));
    }

    public static Target CUSTOMER_PO = Target.the("Customer PO")
            .located(By.xpath("//span[contains(@class,'customer-po')]/strong"));

    //
    public static Target INVOICE_PRODUCT(int i) {
        return Target.the("INVOICE_PRODUCT")
                .located(By.xpath("(//span[@class='product'])[" + i + "]"));
    }

    public static Target INVOICE_SKU(int i) {
        return Target.the("INVOICE_SKU")
                .located(By.xpath("(//span[@class='variant'])[" + i + "]"));
    }

    public static Target INVOICE_TMP(int i) {
        return Target.the("INVOICE_TMP")
                .located(By.xpath("(//span[@class='tmp'])[" + i + "]"));
    }

    public static Target INVOICE_BRAND(int i) {
        return Target.the("INVOICE_BRAND")
                .located(By.xpath("(//span[@class='brand'])[" + i + "]"));
    }

    public static Target INVOICE_QUANTITY(int i) {
        return Target.the("INVOICE_QUANTITY")
                .located(By.xpath("(//span[@class='quantity'])[" + i + "]"));
    }

    public static Target INVOICE_END_QUANTITY(int i) {
        return Target.the("INVOICE_END_QUANTITY")
                .located(By.xpath("(//span[@class='end-qty'])[" + i + "]"));
    }

    public static Target INVOICE_DELIVERY(String value, int i) {
        return Target.the("INVOICE_DELIVERY")
//                .located(By.xpath("(//div[@class='delivery' or @class='lock'])[" + i + "]"));
                .located(By.xpath("(//button[contains(@class,'delivery')]//*[contains(text(),'" + value + "')])[" + i + "]"));
    }

    public static Target INVOICE_FULFILLMENT_DATE(int i) {
        return Target.the("INVOICE_FULFILLMENT_DATE")
                .located(By.xpath("(//input[@placeholder='Pick a date'])[" + i + "]"));
    }

    public static Target INVOICE_FULFILLMENT_DATE_ICON_CLOSE(int i) {
        return Target.the("INVOICE_FULFILLMENT_DATE_ICON_CLOSE")
                .located(By.xpath("(//input[@placeholder='Pick a date'])[" + i + "]//following-sibling::span/span"));
    }


    public static Target INVOICE_WAREHOUSE(int i) {
        return Target.the("INVOICE_WAREHOUSE")
                .located(By.xpath("(//span[contains(@class,'region-warehouse') or contains(@class,'line-item-type-tag')])[" + i + "]"));
    }

    public static Target INVOICE_PRODUCT(String subInvoice, String sku) {
        return Target.the("Product of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/preceding-sibling::td/span[@class='product']"));
    }

    public static Target EXPAND_INVOICE = Target.the("//dd[@class='total-weight']")
            .located(By.xpath("//button[@class='el-button toggler el-button--default el-button--mini']//span[contains(text(),'Expand invoice')]"));

    public static Target INVOICE_SKU = Target.the("")
            .located(By.xpath("//span[@class='variant']"));

    public static Target INVOICE_SKU(String subInvoice, String sku) {
        return Target.the("SKU of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']"));
    }

    public static Target INVOICE_BRAND = Target.the("")
            .located(By.xpath("//span[@class='brand']"));

    public static Target INVOICE_BRAND(String subInvoice, String sku) {
        return Target.the("Brand of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/preceding-sibling::td/span[@class='brand']"));
    }

    public static Target INVOICE_TMP(String subInvoice, String sku) {
        return Target.the("Temp of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/span[@class='tmp']"));
    }

    public static Target INVOICE_QUANTITY(String subInvoice, String sku) {
        return Target.the("Quantity of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/span[@class='quantity']"));
    }

    public static Target INVOICE_QUANTITY_DIRECT(String subInvoice, String sku) {
        return Target.the("Quantity of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/span[text()='Direct']"));
    }

    public static Target INVOICE_END_QUANTITY = Target.the("")
            .located(By.xpath("//span[@class='end-qty']"));

    public static Target INVOICE_END_QUANTITY(String subInvoice, String sku) {
        return Target.the("End quantity of subinvoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/span[@class='end-qty']"));
    }

    public static Target INVOICE_DELIVERY(String subInvoice, String sku, String delivery) {
        return Target.the("")
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/button[contains(@class,'delivery')]//*[contains(text(),'" + delivery + "')]"));
    }

    public static Target INVOICE_WAREHOUSE(String subInvoice, String sku) {
        return Target.the("Warehouse of sub invoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td/span[contains(@class,'region-warehouse')]"));
    }

    public static Target INVOICE_FULFILLMENT_DATE = Target.the("")
            .located(By.xpath("//input[@placeholder='Pick a date']"));


    public static Target INVOICE_FULFILLMENT_DATE(String subInvoice, String sku) {
        return Target.the("Warehouse of sub invoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr/td/span[text()='" + sku + "']/parent::td/following-sibling::td//input[@placeholder='Pick a date']"));
    }

    public static Target INVOICE_FULFILLED_CHECKBOX(String subInvoice, String sku) {
        return Target.the("Fulfilled checkbox of sub invoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr//span[text()='" + sku + "']/parent::td/following-sibling::td//span[contains(@class,'checkbox__input')]"));
    }

    public static Target FULFILL_ALL_ITEM = Target.the("Fulfilled checkbox of sub invoice")
            .locatedBy("//tr[@class='tb order']/td[text()='Fulfilled']//span[@class='el-checkbox__input']");

    public static Target INVOICE_FULFILLED_CHECKBOXED(String subInvoice, String sku) {
        return Target.the("Fulfilled checkbox of sub invoice " + subInvoice)
                .located(By.xpath("//strong[text()='" + subInvoice + "']/ancestor::tr/following-sibling::tr[1]//span[text()='" + sku + "']/parent::td/following-sibling::td//span[contains(@class,'el-checkbox__input is-checked')]"));
    }

    public static Target SUB_INOVICE_IN_RESULT = Target.the("Fulfilled checkbox of sub invoice")
            .locatedBy("//tr[@class='invoice']//span[contains(text(),'Invoice')]/following-sibling::strong");

    /**
     * Non invoice
     */
    public static Target NON_INVOICE_PRODUCT(int i) {
        return Target.the("Product of non invoice ")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='product'])[" + i + "]"));
    }

    public static Target NON_INVOICE_SKU(int i) {
        return Target.the("Sku of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='variant'])[" + i + "]"));
    }

    public static Target NON_INVOICE_BRAND(int i) {
        return Target.the("Brand of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='brand'])[" + i + "]"));
    }

    public static Target NON_INVOICE_TMP(int i) {
        return Target.the("Tmp of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='tmp'])[" + i + "]"));
    }

    public static Target NON_INVOICE_QUANTITY(int i) {
        return Target.the("Quantity of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='quantity'])[" + i + "]"));
    }

    public static Target NON_INVOICE_END_QUANTITY(int i) {
        return Target.the("End quantity of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='end-qty'])[" + i + "]"));
    }

    public static Target NON_INVOICE_DELIVERY(int i, String delivery) {
        return Target.the("Delivery of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//*[contains(@class,'delivery')]//*[contains(text(),'" + delivery + "')])[" + i + "]"));
    }

    public static Target NON_INVOICE_WAREHOUSE(int i) {
        return Target.the("Warehouse of non invoice")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[contains(@class,'warehouse')])[" + i + "]"));
    }

    public static Target LINE_ITEM_QUANTITY(String sku) {
        return Target.the("Line item quantiry of sku " + sku)
                .locatedBy("//span[text()='" + sku + "']/parent::td/following-sibling::td//div[contains(@class,'item-quantity tc')]");
    }

    public static Target UPDATE_LINE_ITEM_FIELD = Target.the("Textbox quantity in popup item quantity")
            .locatedBy("(//div[contains(@x-placement,'start')]//label[text()='Item quantity']/following-sibling::div//input)[1]");

    public static Target CHANGE_QUANTITY__BUTTON_IN_POPUP = Target.the("Change quantity button in popup")
            .locatedBy("//div[@role='dialog']//button/span[text()='Change']");

    public static Target CANCEL_QUANTITY__BUTTON_IN_POPUP = Target.the("Cancel quantity button in popup")
            .locatedBy("//div[@role='dialog']//button/span[text()='Cancel']");

    public static Target NON_INVOICE_SKU(String sku) {
        return Target.the("Product of non invoice ")
                .located(By.xpath("(//tr[@class='invoice non-invoiced']//following-sibling::tr//span[@class='variant' and text()='" + sku + "'])"));
    }

    public static Target DYNAMIC_TARGET(String value) {
        return Target.the(value)
                .locatedBy("//span[contains(@class,'" + value + "')]");
    }

    public static Target DYNAMIC_TARGET2(String value) {
        return Target.the(value)
                .locatedBy("//div[@class='" + value + "']");
    }

    public static Target EXPAND_ORDER = Target.the("Expand order button")
            .locatedBy("//tr[@class='order top']//span[text()='Expand order']");

    // Create new Purchase Order
    public static Target PURCHASE_ORDER_BUTTON = Target.the("The Purchase Order button")
            .located(By.cssSelector("div.summaries >section:nth-child(1) tbody tr.invoice:nth-child(3) .purchase-order button"));

    public static Target DRIVER_LP_FIELD = Target.the("Driver LP field")
            .located(By.cssSelector("div.logisitcs-partner input.el-input__inner"));

    public static Target SUGGESTION_DRIVER_LP_FIRST = Target.the("Suggestion driver LP")
            .located(By.cssSelector("div.popper-logistics-partner-select li:nth-child(1)"));

    public static Target ADMIN_NOTE_FIELD = Target.the("Admin Note field")
            .located(By.cssSelector("div.admin-note input.el-input__inner"));

    public static Target LP_NOTE_FIELD = Target.the("LP Note field")
            .located(By.cssSelector("div.logisitics-partner-note input.el-input__inner"));

    public static Target CREATE_PURCHASE_ORDER_BUTTON = Target.the("Create Purchase Order button")
            .located(By.cssSelector("div.el-form-item.action button"));

    // Set Delivery Method
    public static Target DELIVERY_DETAILS_FROM_VENDOR = Target.the("The place where admin set delivery method")
            .located(By.cssSelector("table.summary .delivery"));

    public static Target DELIVERY_METHOD_FIELD = Target.the("The delivery method field")
            .located(By.cssSelector("div.el-dialog .delivery-method input"));

    public static Target SELF_DELIVER_TO_POD_WAREHOUSE = Target.the("The self deliver to pod warehouse method")
            .located(By.cssSelector("body >div.el-popper li.el-select-dropdown__item:nth-child(4)"));

    public static Target DELIVERY_DATE_FIELD = Target.the("The delivery date field")
            .located(By.cssSelector("div.delivery-date input"));

    public static Target DELIVERY_TIME_FROM = Target.the("The time from")
            .located(By.cssSelector("div.time-range-from input"));

    public static Target DELIVERY_TIME_TO = Target.the("The time to")
            .located(By.cssSelector("div.time-range-to input"));

    public static Target COMMENT_FIELD = Target.the("The comment field")
            .located(By.cssSelector(".comment.el-textarea textarea"));

    public static Target UPDATE_METHOD_BUTTON = Target.the("The Update button")
            .located(By.cssSelector(".el-dialog div.el-form-item__content button"));

    // Set Distribution Center
    public static Target DISTRIBUTION_CENTER = Target.the("Distribution center")
            .located(By.cssSelector(".region-warehouse-select"));

    /**
     * Popup Export lineitem
     */

    public static Target EXPORT_INVOICE_CHECKBOX = Target.the("Invoice checkbox in export popup")
            .locatedBy("//div[contains(@class,'invoice-number')]/preceding-sibling::div/label[contains(@class,'checked')]");

    public static Target ITEM_EXPORT_SKU_CHECKBOX(String sku) {
        return Target.the("Item export of sku " + sku + " checkbox")
                .locatedBy("//div[text()='" + sku + "']/preceding-sibling::div/label[contains(@class,'checked')]");
    }

    public static Target EXPORT_SELECT_ALL_CHECKBOX = Target.the("Select all checkbox in export popup")
            .locatedBy("//div[text()='Select all']/preceding-sibling::div/label[contains(@class,'checked')]");


    public static Target ITEM_EXPORT_SKU(String sku) {
        return Target.the("Item export of sku " + sku)
                .locatedBy("//div[@class='item exported']//div[text()='" + sku + "']");
    }

    public static Target ITEM_EXPORT_PRICE(String sku) {
        return Target.the("Price of sku " + sku)
                .locatedBy("//div[text()='" + sku + "']/following-sibling::div[contains(@class,'case-price')]");
    }

    public static Target ITEM_EXPORT_QUANTITY(String sku) {
        return Target.the("Quantity of sku " + sku)
                .locatedBy("//div[text()='" + sku + "']/following-sibling::div[contains(@class,'quantity')]");
    }

    public static Target ITEM_EXPORT_TOTAL(String sku) {
        return Target.the("Total of sku " + sku)
                .locatedBy("//div[text()='" + sku + "']/following-sibling::div[contains(@class,'total')]");
    }

    // Packing slip page
    public static Target PACKING_SLIP_STORE = Target.the("Packing slip store")
            .locatedBy("//dd[@class='store']");

    public static Target PACKING_SLIP_BUYER = Target.the("Packing slip buyer")
            .locatedBy("//dd[@class='buyer']");

    public static Target PACKING_SLIP_ORDER_BUYER = Target.the("Packing slip order buyer")
            .locatedBy("//dd[@class='order-date']");

    public static Target PACKING_SLIP_ADDRESS = Target.the("Packing slip order address")
            .locatedBy("//dd[@class='address']/div");

    public static Target PACKING_SLIP_SKU(String sku) {
        return Target.the("Sku " + sku)
                .locatedBy("//div[text()='" + sku + "']");
    }

    public static Target PACKING_SLIP_PRODUCT(String sku) {
        return Target.the("Product of " + sku)
                .locatedBy("//div[text()='" + sku + "']/preceding-sibling::div[@class='product']");
    }

    public static Target PACKING_SLIP_BRAND(String sku) {
        return Target.the("Brand of " + sku)
                .locatedBy("//div[text()='" + sku + "']/preceding-sibling::div[@class='brand']");
    }

    public static Target PACKING_SLIP_STORE_CONDITION(String sku) {
        return Target.the("Store condition of " + sku)
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td/div[@class='storage-condition']/span");
    }

    public static Target PACKING_SLIP_UPC(String sku) {
        return Target.the("Upc of " + sku)
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td/div[@class='upc']");
    }

    public static Target PACKING_SLIP_CASE_UPC(String sku) {
        return Target.the("Case Upc of " + sku)
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td/div[@class='case-upc']");
    }

    public static Target PACKING_SLIP_CASE_UNITS(String sku) {
        return Target.the("Case unit of " + sku)
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td/div[@class='case-units']");
    }

    public static Target PACKING_SLIP_QUANTITY(String sku) {
        return Target.the("Quantity of " + sku)
                .locatedBy("//div[text()='" + sku + "']/parent::td/following-sibling::td/div[@class='quantity']");
    }

    /**
     * Purchase order popup
     */

    //span[@class='purchase-order']//strong/span
    public static Target CREATE_PO_BUTTON(String sub) {
        return Target.the("Create Purchase order button")
                .located(By.xpath("//strong[text()='" + sub + "']/parent::a/following-sibling::span//button"));
    }

    public static Target EDIT_PO_BUTTON(String subInvoice) {
        return Target.the("Edit Purchase order button")
                .located(By.xpath("//strong[contains(text(),'" + subInvoice + "')]/parent::a/following-sibling::span[@class='purchase-order']"));
    }

    public static Target PO_POPUP_BUTTON = Target.the("Purchase order button")
            .locatedBy("//span[@class='purchase-order']//button//span");

    public static Target PO_POPUP_BUTTON_CLOSE = Target.the("Purchase order close popup button")
            .locatedBy("//div[@id='global-dialogs']//button[@aria-label='Close']");

    public static Target EDIT_PO_POPUP = Target.the("Edit Purchase order popup")
            .locatedBy("//div[@id='global-dialogs']//span[contains(text(),'Edit')]");
    /**
     * Set business day
     */

    public static Target POSSIBLE_DELIVERY_DAY_LABEL = Target.the("Possible delivery day label")
            .locatedBy("//div[contains(@class,'weekday')]/strong");

    public static Target PREFERRED_WEEKDAY_LABEL = Target.the("Preferred weekdays day label")
            .locatedBy("//div[contains(@class,'preferred-weekdays')]//div/span");

    public static Target RECEIVING_NOTE_LABEL = Target.the("Receiving note label")
            .locatedBy("//div[@class='receiving-note']/span");

    public static Target DIRECT_RECEIVING_NOTE_LABEL = Target.the("Direct receiving note label")
            .locatedBy("//div[contains(@class,'direct-receiving-note')]/span");

    public static Target ADMIN_NOTE_LABEL = Target.the("Admin note label")
            .locatedBy("//textarea[@placeholder='Admin note for order']");

    public static Target BUYER_NOTE_LABEL = Target.the("Buyer note label")
            .locatedBy("//div[contains(@class,'buyer-special-note')]/span");

    /**
     * Delivery stamp
     */

    public static Target DELIVERY_STAMP_BUTTON = Target.the("Delivery stamp button")
            .locatedBy("//div[contains(@class,'deliverable-stamp')]");

    public static Target DELIVERABLE_TYPE = Target.the("Deliverable type text")
            .locatedBy("//dd[@class='type']");

    public static Target DELIVERABLE_DATE = Target.the("Deliverable date text")
            .locatedBy("//dd[@class='delivery-date']");

    public static Target DELIVERABLE_CARRIER = Target.the("Deliverable carrier text")
            .locatedBy("//dd[@class='carrier']");

    public static Target DELIVERABLE_TRACKING_NUMBER = Target.the("Deliverable tracking number text")
            .locatedBy("//dd[@class='tracking-number']");

    public static Target DELIVERABLE_COMMENT = Target.the("Deliverable comment text")
            .locatedBy("//dd[@class='comment']");

    public static Target DELIVERABLE_ETA = Target.the("Deliverable eta text")
            .locatedBy("//dd[@class='eta-time']");

    public static Target DELIVERABLE_PROOF = Target.the("Deliverable proof text")
            .locatedBy("//span[@class='file-name']");

    public static Target DELIVERABLE_DELETE_BUTTON = Target.the("Deliverable confirm button")
            .locatedBy("//span[text()='Create Deliverable']/ancestor::div/following-sibling::div//div[@class='actions clearfix']/button");

    public static Target DELIVERABLE_CLOSE_BUTTON = Target.the("Deliverable close button")
            .locatedBy("//span[text()='Create Deliverable']//ancestor::div/following-sibling::button[@aria-label='Close']");

    /**
     * Shippo stamp
     */

    public static Target SHIPPO_STAMP_BUTTON = Target.the("Shippo stamp button")
            .locatedBy("//div[contains(@class,'shippo-label-stamp')]");

    public static Target SHIPPO_STAMP_NUMBER = Target.the("Shippo stamp number")
            .locatedBy("//div[contains(@class,'shippo-label-stamp')]//div[@class='number']");

    public static Target SHIPPO_STAMP_NAME = Target.the("Shippo stamp name")
            .locatedBy("//div[contains(@class,'shippo-label-stamp')]//span[@class='name']");

    public static Target SHIPPO_STAMP_ADDRESS_FROM = Target.the("Address from shippo text")
            .locatedBy("(//dt[text()='Address from']/following-sibling::dd)[1]");

    public static Target SHIPPO_STAMP_ADDRESS_TO = Target.the("Address to shippo text")
            .locatedBy("(//dt[text()='Address to']/following-sibling::dd)[1]");

    /**
     * Popup create delivery
     */

    public static Target DELIVERY_CHOOSE_BUTTON = Target.the("Delivery choose button")
            .locatedBy("//button[contains(@class,'delivery')]");

    public static Target CREATE_DELIVERY_POPUP = Target.the("Create delivery popup")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]");

    public static Target DELIVERY_POPUP = Target.the("Create delivery popup")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]");

    public static Target DELIVERY_METHOD_DROPDOWN = Target.the("Delivery method dropdown")
            .locatedBy("//label[text()='Delivery method']/following-sibling::div//input");

    public static Target DELIVERY_ALERT = Target.the("Delivery alert")
            .locatedBy("//span[@class='el-alert__title']");

    public static Target DELIVERY_POPUP_TITLE = Target.the("Title in delivery popup")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]//span[contains(@class,'title')]");

    public static Target DELIVERY_POPUP_TYPE_LABEL = Target.the("Delivery popup type label")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]//dd[contains(@class,'type')]");

    public static Target DELIVERY_POPUP_COMMENT_LABEL = Target.the("Delivery popup comment label")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]//dd[contains(@class,'comment')]");

    public static Target DELIVERY_POPUP_CLOSE_BUTTON = Target.the("Close popup")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Deliverable')]//button[@aria-label='Close']");
    /**
     * Edit line item
     */
    public static Target BUTTON_EDIT_LINEITEM = Target.the("Edit line item button")
            .locatedBy("//button[contains(@class,'edit-toggler')]//span[contains(text(),'Edit')]");

    public static Target BUTTON_CANCEL_EDIT_LINEITEM = Target.the("Cancel edit line item button")
            .locatedBy("//button[contains(@class,'edit-toggler')]//span[contains(text(),'Cancel edit')]");

    public static Target REMOVE_LINE_ITEM_BUTTON(String sku) {
        return Target.the("Remove line item " + sku + " button")
                .locatedBy("//span[text()='" + sku + "']/parent::td/following-sibling::td/button");
    }

    public static Target HELP_OF_QUANTITY_OF_LINEITEM(String subInvoice, String skuID) {
        return Target.the("Icon help of line item")
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr/following-sibling::tr//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//span[contains(@class,'help-icon popover')]");
    }

    /**
     * Export summary
     */

    public static Target EXPORT_BUTTON = Target.the("Export CSV")
            .locatedBy("");


}

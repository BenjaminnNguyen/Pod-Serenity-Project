package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class GhostOrderPage {

    public static Target GHOST_ORDER_HEADER_ID = Target.the("Ghost order header id")
            .located(By.xpath("//header//span[contains(text(),'Convert ghost order')]"));

    /**
     * Result after search
     */

    public static Target SELECT_ALL_ORDER = Target.the("Select all order in result")
            .located(By.xpath("(//input[@type='checkbox'])[1]"));

    public static Target SELECT_ORDER_RESULT(String ghostOrderNumber) {
        return Target.the("Checkbox select Order in result")
                .locatedBy("//a[text()='" + ghostOrderNumber + "']/ancestor::td/preceding-sibling::td/div//input");
    }

    public static Target ORDER_RESULT(String ghostOrderNumber) {
        return Target.the("Order in result")
                .located(By.xpath("//a[text()='" + ghostOrderNumber + "']"));
    }

    public static Target ORDER_RESULT = Target.the("Order in result")
            .located(By.xpath("//td[contains(@class,'number')]//a"));

    public static Target CUSTOMER_PO_RESULT = Target.the("Customer po in result")
            .located(By.xpath("//td[contains(@class,'customer-po')]//span"));

    public static Target CREATED_DATE_RESULT = Target.the("Created date in result")
            .located(By.xpath("//td[contains(@class,'created_at')]//span"));

    public static Target CREATOR_RESULT = Target.the("Creator in result")
            .located(By.xpath("//td[contains(@class,'crator')]//span"));

    public static Target BUYER_RESULT = Target.the("Buyer in result")
            .located(By.xpath("//td[contains(@class,'buyer')]//span"));

    public static Target STORE_RESULT = Target.the("Store in result")
            .located(By.xpath("//td[contains(@class,'store')]//span"));

    public static Target REGION_RESULT = Target.the("Region in result")
            .located(By.xpath("//td[contains(@class,'region')]//span"));

    public static Target TOTAL_RESULT = Target.the("Total in result")
            .located(By.xpath("//td[contains(@class,'total')]//div[@class='bold']"));

    /**
     * General Information
     */

    public Target CUSTOMER_PO_GENERAL = Target.the("Customer PO in general information")
            .located(By.xpath("//dd[@class='customer-po']//span[@class='customer-po']"));

    public Target DATE_GENERAL = Target.the("Date in general information")
            .located(By.xpath("//dd[@class='date']/span"));

    public Target REGION_GENERAL = Target.the("Region in general information")
            .located(By.xpath("//dd[@class='region']/span"));

    public Target BUYER_GENERAL = Target.the("Region in general information")
            .located(By.xpath("//dd[@class='buyer']/div"));

    public Target STORE_GENERAL = Target.the("Store in general information")
            .located(By.xpath("//dd[@class='store']/div"));

    public Target ORDER_VALUE_GENERAL = Target.the("Order value in general information")
            .located(By.xpath("//dd[@class='order-value']"));

    public Target CREATOR_GENERAL = Target.the("Creator in general information")
            .located(By.xpath("//dd[@class='creator']/div"));

    public Target MANAGED_GENERAL = Target.the("Managed in general information")
            .located(By.xpath("//dd[@class='managed']"));

    public Target LAUNCHED_GENERAL = Target.the("Managed in general information")
            .located(By.xpath("//dd[@class='launched-by']"));

    public Target ADDRESS_GENERAL = Target.the("Address in general information")
            .located(By.xpath("//div[@class='address-stamp']"));

    public Target ADMIN_NOTE_GENERAL = Target.the("Admin note in general information")
            .located(By.xpath("//span[@class='note-to-admin']"));

    /**
     * Ghost order detail - Line items
     */
    public Target SKU_ID_DETAIL(String skuID) {
        return Target.the("SKU ID in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']"));
    }

    public Target SKU_DETAIL(String skuID) {
        return Target.the("SKU in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='variant']/span"));
    }

    public Target PRODUCT_DETAIL(String skuID) {
        return Target.the("Product in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='product']/span"));
    }

    public Target BRAND_DETAIL(String skuID) {
        return Target.the("Brand in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='brand']/span"));
    }

    public Target TAG_PD_DETAILS(String skuID) {
        return Target.the("Tag PD in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/following-sibling::span/img"));
    }

    public Target TAG_PE_DETAILS(String skuID) {
        return Target.the("Tag PE in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/following-sibling::span/span"));
    }

    public Target CASE_PRICE_DETAILS(String skuID) {
        return Target.the("Case price in line item of ghost order detail")
                .located(By.xpath(" //span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td/div[@class='case-price']"));
    }

    public Target UNITS_DETAILS(String skuID) {
        return Target.the("Units in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td/div[@class='units']"));
    }

    public Target QUANTITY_DETAILS(String skuID) {
        return Target.the("Quantity in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td/div[contains(@class,'quantity')]//div[contains(@class,'item-quantity')]"));
    }

    public Target END_QUANTITY_DETAILS(String skuID) {
        return Target.the("End quantity in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td//span[@class='end-qty']"));
    }

    public Target TOTAL_DETAILS(String skuID) {
        return Target.the("End quantity in line item of ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td/span[@class='end-qty']/parent::td/following-sibling::td//*"));
    }

    public Target LINE_ITEM_DELETE(String skuName) {
        return Target.the("Line item delete")
                .located(By.xpath("//span[text()='" + skuName + "']//ancestor::td/following-sibling::td//div[contains(@class,'quantity')]/button"));
    }

    /**
     * Ghost order detail - Action
     */

    public static Target DELETE_GHOST_ORDER = Target.the("Delete ghost order")
            .located(By.xpath("(//div[@class='page-header']//div[@class='actions']/button)[1]"));

    /**
     * Convert ghost order detail - Line items
     */

    public Target BRAND_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Brand in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='brand']/span");
    }

    public Target PRODUCT_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Product in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='product']/span");
    }

    public Target SKU_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("SKU in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='variant']/span");
    }

    public Target PRICE_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Price in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td/div[@class='case-price']");
    }

    public Target UNITS_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Units in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td/div[@class='units']");
    }

    public Target QUANTITY_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Quantity in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//input");
    }

    public Target QUANTITY_IN_LINE_ITEM_CONVERT1(String skuID) {
        return Target.the("Quantity in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//span/div/div[@class='item-quantity']");
    }

    public Target END_QUANTITY_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("End quantity in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//span[@class='end-qty']");
    }

    public Target TOTAL_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Total in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//strong[@class='totals']");
    }

    public static Target MESSAGE_MOV = Target.the("Message require of MOV")
            .locatedBy("//div[contains(@class,'ghost-order')]//following-sibling::div//p");

    public static Target SOS_ALERT = Target.the("Small order surcharge alert")
            .locatedBy("//div[@class='small-order-surcharge-alert']");

    public static Target LS_ALERT = Target.the("Logistics surcharge alert")
            .locatedBy("//div[@class='logistics-surcharge-alert']");

    public Target NEW_TOTAL_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("New total in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//div[@class='totals']/strong");
    }

    public Target OLD_TOTAL_IN_LINE_ITEM_CONVERT(String skuID) {
        return Target.the("Old total in line item of sku ID " + skuID + " in convert ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//div[@class='totals']/div");
    }

    /**
     * Convert ghost order detail - Summary
     */
    public Target DYNAMIC_PRICE_IN_SUMMARY(String title, String index) {
        return Target.the("Create new order button")
                .locatedBy("(//td[text()='" + title + "']/following-sibling::td)[" + index + "]");
    }

    /**
     * Popup MOQ alert nếu convert ghost order thành real order
     */
    public static Target MOQ_ALERT_POPUP_CONVERT = Target.the("MOQ alert popup convert")
            .located(By.xpath("//p[contains(text(),\"The line-item(s) highlighted doesn't meet the minimum order quantity (MOQ). Please click\")]"));

    /**
     * Create form
     */
    public static Target ERROR_MESSAGE_TEXTBOX(String title) {
        return Target.the("Error message textbox " + title)
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div/div[contains(@class,'error')]"));
    }

    public static Target ERROR_MESSAGE_LINE_ITEM_TEXTBOX = Target.the("Error message line item textbox")
            .located(By.xpath("//div[text()='Line items']/following-sibling::div[contains(@class,'error')]"));

    public static Target SOS_STAMP = Target.the("Sos stamp")
            .located(By.xpath("//span[contains(@class,'small-order-surcharge-status')]"));

    public static Target LS_STAMP = Target.the("Ls stamp")
            .located(By.xpath("//span[contains(@class,'logistics-surcharge-status')]"));

    public static Target FILL_ADDRESS_INFO = Target.the("Fill info address")
            .located(By.xpath("//button//span[text()='Fill buyer address and receiving options']"));

    public static Target STREET2_TEXTBOX = Target.the("Street 2 textbox in create ghost order")
            .located(By.xpath("(//label[text()='Street address']/following-sibling::div//input)[2]"));

    /**
     * Add line item
     */

    public static Target QUANTITY_OF_ITEM_TEXTBOX(String skuName) {
        return Target.the("Quantity of " + skuName)
                .located(By.xpath("//span[normalize-space()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'input-number')]//input"));
    }

    public static Target REASON_ADD_TEXTBOX(String skuName) {
        return Target.the("Reason of " + skuName)
                .located(By.xpath("//span[normalize-space()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'reason-change')]//input"));
    }

    public static Target NOTE_ADD_TEXTBOX(String skuName) {
        return Target.the("Note of " + skuName)
                .located(By.xpath("//span[normalize-space()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'note')]//textarea"));
    }

    public static Target HISTORY_ADD_TEXTBOX(String skuName) {
        return Target.the("Note of " + skuName)
                .located(By.xpath("//span[normalize-space()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'quantity')]/span"));
    }

    public static Target DELETE_LINE_ITEM_BUTTON(String skuName) {
        return Target.the("Delete sku" + skuName)
                .located(By.xpath("//span[text()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'quantity')]/button"));
    }

    /**
     * Bulk popup
     */

    public static Target CONVERT_BULK_BUTTON = Target.the("Convert bulk button popup")
            .located(By.xpath("//a[text()='Convert selected']"));

    public static Target CONVERT_BULK_BUTTON(String order) {
        return Target.the("Convert bulk button popup")
                .located(By.xpath("//a[@title='Expand ghost order']//span[text()='" + order + "']"));
    }

    /**
     * Line item of order in bulk
     */

    public Target QUANTITY_BULK(String skuID) {
        return Target.the("Quantity in line item of bulk ghost order detail")
                .located(By.xpath("//span[text()='" + skuID + "']/ancestor::td[@class='item']/following-sibling::td/div[contains(@class,'quantity')]//input"));
    }

    public static Target DELETE_LINE_ITEM_BULK(String skuName) {
        return Target.the("Delete sku " + skuName)
                .located(By.xpath("//span[text()='" + skuName + "']/ancestor::td/following-sibling::td//button"));
    }

    public Target NEW_TOTAL_IN_LINE_ITEM_BULK(String skuID) {
        return Target.the("New total in line item of sku ID " + skuID + " in bulk ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//div[@class='totals']/strong");
    }

    public Target OLD_TOTAL_IN_LINE_ITEM_BULK(String skuID) {
        return Target.the("Old total in line item of sku ID " + skuID + " in bulk ghost order")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//div[@class='totals']/div");
    }

    public static Target INCREASE_QUANTITY_OF_ITEM_TEXTBOX(String skuName) {
        return Target.the("Quantity of " + skuName)
                .located(By.xpath("//span[text()='" + skuName + "']/ancestor::td/following-sibling::td//div[contains(@class,'input-number')]//span[contains(@class,'increase')]"));
    }
}

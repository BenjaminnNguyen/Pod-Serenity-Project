package cucumber.user_interface.admin.store;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class AllStoresPage {


    public static Target GENERAL_INFO_HEADER = Target.the("General information header")
            .locatedBy("//div[text()='General information']");

    public static Target STORE_ID(String storeName) {
        return Target.the("Result Store id")
                .locatedBy("//span[text()='" + storeName + "']//ancestor::td/preceding-sibling::td/div");
    }

    public static Target STORE_NAME = Target.the("Result Store name")
            .locatedBy("//td[contains(@class,'store')]//span");

    public static Target REGION_RESULT = Target.the("Result Region")
            .locatedBy("//td[contains(@class,'region')]//span");

    public static Target SOS_RESULT = Target.the("Result Small order surcharge")
            .locatedBy("(//td[contains(@class,'small-order-surcharge')]//span)[2]");

    public static Target SIZE_RESULT = Target.the("Size in result")
            .locatedBy("//td[contains(@class,'size')]//div");

    public static Target TYPE_RESULT = Target.the("Type in result")
            .locatedBy("//td[contains(@class,'type')]//div");

    public static Target CONTACT_RESULT = Target.the("Contact in result")
            .locatedBy("//td[contains(@class,'contact')]//span");

    public static Target MANAGED_BY_RESULT = Target.the("Managed by in result")
            .locatedBy("//td[contains(@class,'managed-by')]//span");

    public static Target LAUNCH_BY_RESULT = Target.the("Launched by in result")
            .locatedBy("//td[contains(@class,'launched-by')]//span");

    public static Target DELIVERY_RESULT = Target.the("Contact in result")
            .locatedBy("//td[contains(@class,'delivery')]/div/div");

    public static Target BUYER_NAME_RESULT(String name) {
        return Target.the("Buyer name in result")
                .locatedBy("//td[contains(@class,'name')]//span[text()='" + name + "']");
    }

    public static Target FIRST_RESULT_STORE = Target.the("First result store")
            .locatedBy("(//a[@class='name'])[1]");

    //Popup Warning deactivate store
    public static Target WARNING_POPUP = Target.the("Warning popup")
            .locatedBy("//div[@role='dialog']//span[text()='Warning']");

    public static Target DELETE_BUTTON_BY_STORE(String state) {
        return Target.the("Delete button by store")
                .locatedBy("//span[text()='" + state + "']/ancestor::td/following-sibling::td//button[3]");
    }

    public static Target POSSIBLE_RECEIVING_WEEKDAYS_LABEL = Target.the("All possible delivery days")
            .located(org.openqa.selenium.By.xpath("(//dt[text()='All possible delivery days']/following-sibling::dd/div)[1]"));

    public static Target SET_RECEIVING_WEEKDAYS_LABEL = Target.the("Set receiving weekdays")
            .located(org.openqa.selenium.By.xpath("(//dt[text()='Set receiving weekday']/following-sibling::dd/div)[1]"));

    public static Target POPUP_CHOOSE_DAY_DELIVERY = Target.the("Popup choose day delivery")
            .located(org.openqa.selenium.By.xpath("//label[text()='Choose all possible delivery days']"));

    public static Target RECEIVING_TIME_LABEL = Target.the("Receiving time label")
            .located(org.openqa.selenium.By.xpath("//dt[text()='Receiving time']/following-sibling::dd/div"));

    public static Target RECEIVING_TIME_FROM_TEXTBOX = Target.the("Receiving time from textbox")
            .located(org.openqa.selenium.By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//label[contains(text(),'Receiving time')]//following-sibling::div//input)[1]"));

    public static Target RECEIVING_TIME_TO_TEXTBOX = Target.the("Receiving time from textbox")
            .located(org.openqa.selenium.By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//label[contains(text(),'Receiving time')]//following-sibling::div//input)[2]"));
    /**
     * Buyer Company Detail Page
     */
    public static Target GENERAL_INFO = Target.the("General information")
            .located(By.xpath("//div[text()='General information']"));

    public static Target DYNAMIC_DETAIL(String title) {
        return Target.the(title)
                .locatedBy("//span[@class='" + title + "']");
    }

    public static Target ADDRESS_DETAIL = Target.the("Address of detail")
            .located(By.xpath("//div[contains(@class,'address-stamp')]/span"));

    public static Target STATE_DETAIL = Target.the("State of detail")
            .located(By.xpath("//div[@class='status-tag']"));

    public static Target INVOICE_OPTION_DETAIL = Target.the("Invoice of detail")
            .locatedBy("(//div[contains(@class,'invoice-option')]//span)[2]");

    public static Target SEND_INVOICE_DETAIL = Target.the("Send invoice of detail")
            .locatedBy("//div[@class='send-invoice-options']/div");

    public static Target SEND_INVOICE_DETAIL_NO = Target.the("Send invoice of detail")
            .locatedBy("//div[contains(@class,'send-invoice')]/span/span");

    public static Target DIRECT_RECEIVING_NOTE(String value) {
        return Target.the("Direct receiving note of detail")
                .locatedBy("//span[text()='" + value + "']");
    }

    public static Target DYNAMIC_DETAIL2(String title) {
        return Target.the(title)
                .locatedBy("//div[@class='" + title + "']");
    }

    public static Target WITHIN_7_BUSINESS_CHECKBOX = Target.the("Check box within 7 business checkbox")
            .locatedBy("//span[text()='Within 7 business days']/preceding-sibling::span");

    public static Target POSSIBLE_DELIVERY_DAY_TEXTBOX_POPUP = Target.the("Textbox in popup all possible delivery day")
            .locatedBy("//div[contains(@x-placement,'start')]//div[contains(@class,'weekdays')]");

    public static Target DYNAMIC_ITEM_DROPDOWN_CHECKED(String value) {
        return Target.the(value)
                .located(org.openqa.selenium.By.xpath("//div[contains(@x-placement,'start')]//div[@class='el-scrollbar']//li[contains(@class,'selected')]//*[text()='" + value + "']"));
    }

    public static Target ROUTE = Target.the("Route")
            .locatedBy("(//dt[text()='Route']/following-sibling::dd/div)[1]");

    public static Target REFERRED_BY = Target.the("Referred by")
            .locatedBy("(//dt[text()='Referred by']/following-sibling::dd/div)[1]");

    public static Target EXPRESS_RECEIVING_NOTE = Target.the("Express receiving note")
            .locatedBy("(//dt[text()='Express receiving note']/following-sibling::dd/div)[1]");

    public static Target DIRECT_RECEIVING_NOTE = Target.the("Direct receiving note")
            .locatedBy("(//dt[text()='Direct receiving note']/following-sibling::dd/div)[1]");

    public static Target TOOLTIP_TEXTBOX = Target.the("Tooltip textbox")
            .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//input)[1]");

    public static Target LIFTGATE_REQUIRE = Target.the("Liftgate required at delivery")
            .locatedBy("//div[contains(@class,'lift-gate')]/span");

    public static Target RETAILER_STORE = Target.the("Retailer store")
            .locatedBy("(//dt[text()='Retailer Store #']/following-sibling::dd//div[contains(@class,'content')]/span)[1]");

    /**
     * Buyer Company Detail Page - AP Email
     */

    public static Target D_AP_EMAIL_DETAIL(int index) {
        return Target.the("AP Email " + index)
                .locatedBy("(//div[@class='ap-email']/div/span)[" + index + "]");
    }

    /**
     * Buyer Company Detail Page - SOS
     */

    public static Target APPLY_SOS = Target.the("Apply small order surcharge")
            .locatedBy("//div[@class='boolean-stamp has-surcharge']/span/span");

    public static Target SOS_THRESHOLD = Target.the("Small order surcharge threshold")
            .locatedBy("//div[@class='surcharge-threshold']");

    public static Target SOS_AMOUNT = Target.the("Small order surcharge amount")
            .locatedBy("//div[@class='surcharge-fee-cents']");

    /**
     * Buyer Company Detail Page - Set receiving weekday
     */

    public static Target SET_RECEIVING_WEEKDAY_SELECTED = Target.the("Set receiving weekdays selected")
            .located(org.openqa.selenium.By.xpath("//div[@x-placement]//li[contains(@class,'selected')]"));

    /**
     * Buyer Company Detail Page - Address
     */

    public static Target ADDRESS_DETAIL_EDIT = Target.the("Address detail edit button")
            .locatedBy("//dt[text()='Address']//following-sibling::dd//a");

    public static Target D_ADDRESS_TEXTBOX(String title) {
        return Target.the(title + " textbox in address popup")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target ADDRESS_STREET1_TEXTBOX = Target.the("Street1 textbox in address popup")
            .locatedBy("(//label[text()='Street']/following-sibling::div//input)[1]");

    public static Target ADDRESS_STREET2_TEXTBOX = Target.the("Street1 textbox in address popup")
            .locatedBy("(//label[text()='Street']/following-sibling::div//input)[2]");
    /**
     * Create new store
     */

    public static Target CREATE_STORE_BUTTON = Target.the("Create store button")
            .locatedBy("//div[@class='page-header']//span[text()='Create']");

    public static Target D_CREATE_TEXTBOX(String title) {
        return Target.the(title + " textbox")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target D_CREATE_TEXTAREA(String title) {
        return Target.the(title + " textarea")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//textarea");
    }

    public static Target D_CREATE_TEXTBOX_ERROR(String title) {
        return Target.the(title + " textbox error message")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//div[contains(@class,'error')]");
    }

    public static Target D_CREATE_SWITCH(String title) {
        return Target.the(title + " switch")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div/div");
    }

    public static Target D_CREATE_ITEM_DROP(String state) {
        return Target.the(state + " item drop")
                .locatedBy("//div[contains(@class,'address-state')]//span[text()='" + state + "']");
    }

    public static Target CREATE_STORE_ALL_POSSIBLE_DELIVERY_TEXTBOX = Target.the("Create store all possible delivery days textbox")
            .locatedBy("//label[text()='All possible delivery days']/following-sibling::div//div[@class='el-select prefer']//input");

    public static Target CREATE_STORE_ALL_POSSIBLE_DELIVERY_CHECKBOX = Target.the("Create store all possible delivery days checkbox")
            .locatedBy("//label[text()='All possible delivery days']/following-sibling::div//span[text()='Within 7 business days']");

    public static Target CREATE_STORE_SET_RECEIVING_WEEKDAY_TEXTBOX = Target.the("Create store set receiving weekdays textbox")
            .locatedBy("//label[text()='Set receiving weekdays']/following-sibling::div//input");

    public static Target ICON_CHECKED_SET_RECEIVING_WEEKDAY = Target.the("")
            .locatedBy("//div[contains(@x-placement,'start')]//li[contains(@class,'selected')]");

    public static Target CREATE_STORE_RECEIVING_TIME_FROM_TEXTBOX = Target.the("Create store receiving time from textbox")
            .located(org.openqa.selenium.By.xpath("(//label[contains(text(),'Receiving time')]//following-sibling::div//input)[1]"));

    public static Target CREATE_STORE_RECEIVING_TIME_TO_TEXTBOX = Target.the("Create store receiving time from textbox")
            .located(org.openqa.selenium.By.xpath("(//label[contains(text(),'Receiving time')]//following-sibling::div//input)[2]"));


    public static Target CREATE_STORE_TAG_ADDED_EXPIRY_DATE(String tag) {
        return Target.the("Create store tags added expiry date")
                .located(By.xpath("//div[@class='tag']//div[text()='" + tag + "']/parent::div/following-sibling::div/input"));
    }

    public static Target CREATE_STORE_TAG_ADDED_DELETE_BUTTON(String tag) {
        return Target.the("Tag delete button")
                .located(By.xpath("//div[@class='tag']//div[text()='" + tag + "']/parent::div/following-sibling::div/div[@class='actions']"));
    }

    public static Target CREATE_STORE_APPLY_SOS = Target.the("Create store apply small order surchage checkbox")
            .located(org.openqa.selenium.By.xpath("//label[contains(text(),'Apply small order surcharge')]//following-sibling::div/div"));

    public static Target CREATE_STORE_DEFAULT_SOS_CONFIG = Target.the("Create store default small order surcharge configuration")
            .located(org.openqa.selenium.By.xpath("//label[contains(text(),'Default small order surcharge configuration')]//following-sibling::div/div"));

    /**
     * Footer link
     */

    public static Target D_FOOTER_LINK(String value) {
        return Target.the("Footer link " + value)
                .located(By.xpath(" //a[text()=\"" + value + "\"]"));
    }

    /**
     * Credit memos
     */

    public static Target CREDIT_MEMOS = Target.the("Credit memos")
            .locatedBy("//div[@class='section-title' and text()='Credit memos']");

    public static Target CREDIT_MEMOS(String value) {
        return Target.the("Credit memos " + value)
                .locatedBy("//div[contains(@class,'credit-memos')]/a[text()='" + value + "']");
    }

    public static Target CREDIT_MEMOS_STATE = Target.the("Credit memos state")
            .locatedBy("//div[@aria-hidden='false']/div[@class='tooltip-inner']");

    /**
     * Preferred Warehouses
     */
    public static Target WAREHOUSE(String warehouse) {
        return Target.the("Preferred warehouse")
                .locatedBy("//table[@class='list-warehouses']//td[text()='" + warehouse + "']");
    }

    public static Target WAREHOUSE_ADDRESS(String warehouse) {
        return Target.the("Preferred warehouse address")
                .locatedBy("(//table[@class='list-warehouses']//td[text()='" + warehouse + "']/following-sibling::td)[1]");
    }

    public static Target WAREHOUSE_DISTANCE(String warehouse) {
        return Target.the("Preferred warehouse distance")
                .locatedBy("(//table[@class='list-warehouses']//td[text()='" + warehouse + "']/following-sibling::td)[2]");
    }

    /**
     * Store - History of mileage
     */

    public static Target HISTORY_MILEAGE = Target.the("History of mileage")
            .locatedBy("//dt[contains(text(),'Mileage')]/following-sibling::dd//span[@class='help-icon popover']");

    public static Target MILEAGE_HISTORY_STATE = Target.the("Mileage value")
            .locatedBy("(//div[@x-placement]//td[@class='value'])[1]");

    public static Target MILEAGE_HISTORY_UPDATE_BY = Target.the("Mileage history update by")
            .locatedBy("(//div[@x-placement]//td[@class='initated-by'])[1]");

    public static Target MILEAGE_HISTORY_UPDATE_ON = Target.the("Mileage history update on")
            .locatedBy("(//div[@x-placement]//td[@class='date'])[1]");

}

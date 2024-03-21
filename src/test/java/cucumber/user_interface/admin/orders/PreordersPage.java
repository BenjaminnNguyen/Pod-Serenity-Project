package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class PreordersPage {
    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target SHOW_FILTER = Target.the("Show Filter")
            .located(By.cssSelector("div.search-bar .toggler.collapsed"));

    public static Target SEARCH_BUTTON = Target.the("Search button")
            .located(By.cssSelector("button.search"));

    public static Target RESET_BUTTON = Target.the("Reset button")
            .located(By.cssSelector("button.reset"));


    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@style,'absolute')]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN1(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@style,'absolute')]//div[@class='el-scrollbar']//div[text()='" + value + "']"));
    }


    public static Target RESULT_BY_ID(String idPre) {
        return Target.the("Result in table by")
                .locatedBy("//a[contains(text(),'" + idPre + "')]");
    }

    /**
     * Pre order details
     */

    public static Target PRODUCT_IN_LINE_ITEM = Target.the("Product in line item")
            .locatedBy("//a[@class='product']/span");

    public static Target ALL_SKU_CHECKBOX = Target.the("Checkbox tick all sku")
            .locatedBy("//th[text()='SKU']/preceding-sibling::th");

    public static Target CREATE_ORDER_BUTTON = Target.the("Create order button")
            .locatedBy("//button//span[text()='Create Order']");

    public static Target CONFIRM_POPUP_BUTTON = Target.the("OK button confirm popup")
            .locatedBy("//button//span[contains(text(),'OK')]");

    /**
     * Create New Order
     */

    public static Target CREATE_NEW_ORDER_TEXTBOX(String value) {
        return Target.the("Textbox" + value)
                .located(By.xpath("(//label[text()='" + value + "']/following-sibling::div//input)[1]"));
    }

    public static Target CREATE_NEW_ORDER_BUTTON = Target.the("Create new order button")
            .locatedBy("//button//span[contains(text(),'Create')]");

    public static Target DYNAMIC_ITEM(String state) {
        return Target.the("The item " + state)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + state + "']"));
    }

    /**
     * Summary table
     */
    public static Target DYNAMIC_PRICE_IN_SUMMARY(String title, String index) {
        return Target.the("Create new order button")
                .locatedBy("(//td[text()='" + title + "']/following-sibling::td)[" + index + "]");

    }

    public static Target ID_IN_RESULT_TABLE(String id) {
        return Target.the("Buyer " + id)
                .located(By.xpath("//a[contains(text(),'" + id + "')]"));
    }

    public static Target BUYER_IN_RESULT_TABLE(String id) {
        return Target.the("Buyer " + id)
                .located(By.xpath("//a[contains(text(),'" + id + "')]//ancestor::td/following-sibling::td[contains(@class,'buyer')]//span"));
    }

    public static Target STORE_IN_RESULT_TABLE(String id) {
        return Target.the("Store " + id)
                .located(By.xpath("//a[contains(text(),'" + id + "')]//ancestor::td/following-sibling::td[contains(@class,'store')]//span"));
    }

    public static Target STARTDATE_IN_RESULT_TABLE(String id) {
        return Target.the("Start date " + id)
                .located(By.xpath("//a[contains(text(),'" + id + "')]//ancestor::td/following-sibling::td[contains(@class,'start-date')]//span"));
    }

    public static Target STATUS_IN_RESULT_TABLE(String id) {
        return Target.the("Start date " + id)
                .located(By.xpath("//a[contains(text(),'" + id + "')]//ancestor::td/following-sibling::td[contains(@class,'status')]//div[@class='status-tag']"));
    }

    /**
     * Pre-Order Details - General Info
     */

    public static Target GENERAL_INFO_HEADER = Target.the("General Info Header")
            .locatedBy("//div[text()='General information']");

    public static Target DATE_FIELD = Target.the("Date in General Info")
            .locatedBy("//dd[@class='date']/span");

    public static Target STORE_FIELD = Target.the("Store in General Info")
            .locatedBy("//div[@class='store']");

    public static Target TOTAL_VALUE_FIELD = Target.the("Total value in General Info")
            .locatedBy("//dd[@class='total-value']");

    public static Target STATE_FIELD = Target.the("State in General Info")
            .locatedBy("//dt[text()='State']/following-sibling::dd//div[contains(@class,'status-tag')]");

    public static Target ADDRESS_FIELD = Target.the("Address in General Info")
            .locatedBy("//div[@class='address-stamp']");

    /**
     * Pre-Order Details - Line Item
     */
    public static Target SKU_DETAIL(String sku) {
        return Target.the(sku)
                .located(By.xpath("//span[text()='" + sku + "']"));
    }

    public static Target PRODUCT_DETAIL(String sku) {
        return Target.the("Product")
                .located(By.xpath("//span[text()='" + sku + "']/parent::div/preceding-sibling::a/span"));
    }

    public static Target BRAND_DETAIL(String sku) {
        return Target.the("Brand")
                .located(By.xpath("//span[text()='" + sku + "']/parent::div/preceding-sibling::span"));
    }

    public static Target CASE_PRICE_DETAIL(String sku) {
        return Target.the("Case price")
                .located(By.xpath("//span[text()='" + sku + "']/ancestor::td/following-sibling::td/div[@class='case-price']"));
    }

    public static Target UNIT_DETAIL(String sku) {
        return Target.the("Unit/case")
                .located(By.xpath("//span[text()='" + sku + "']/ancestor::td/following-sibling::td/div[@class='units']"));
    }

    public static Target QUANTITY_DETAIL(String sku) {
        return Target.the("Quantity")
                .located(By.xpath("//span[text()='" + sku + "']/ancestor::td/following-sibling::td/div[@class='quantity']"));
    }

    public static Target STATE_DETAIL(String sku) {
        return Target.the("State")
                .located(By.xpath("//span[text()='" + sku + "']/ancestor::td/following-sibling::td/div[@class='status-tag state']"));
    }

    public static Target AVAILABILITY_DETAIL(String sku) {
        return Target.the("Availability")
                .located(By.xpath("//span[text()='" + sku + "']/ancestor::td/following-sibling::td/div[@class='status-tag avaibility']"));
    }
}

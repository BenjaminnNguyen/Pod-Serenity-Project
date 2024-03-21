package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class PurchaseRequestsPage {

    /**
     * Result after search
     */

    public static Target LIST_RESULT_NUMBER_PURCHASE(String email) {
        return Target.the("Number purchase request in list result")
                .locatedBy("//a[text()='" + email + "']/ancestor::td/preceding-sibling::td[contains(@class,'number')]//a");
    }

    public static Target LIST_RESULT_CURRENT_RETAIL(String email) {
        return Target.the("Current retail partner in list result")
                .locatedBy("//a[text()='" + email + "']/ancestor::td/preceding-sibling::td[contains(@class,'current-retail-partner')]//span");
    }

    public static Target LIST_RESULT_BUYER(String email) {
        return Target.the("Buyer in list result")
                .locatedBy("//a[text()='" + email + "']/preceding-sibling::div");
    }

    public static Target LIST_RESULT_EMAIL(String email) {
        return Target.the("Email in list result")
                .locatedBy("//a[text()='" + email + "']");
    }

    public static Target LIST_RESULT_STORE(String email) {
        return Target.the("Store in list result")
                .locatedBy("//a[text()='" + email + "']/ancestor::td/following-sibling::td[contains(@class,'store-name')]//div");
    }

    public static Target LIST_RESULT_STATUS(String email) {
        return Target.the("Status in list result")
                .locatedBy("//a[text()='" + email + "']/ancestor::td/following-sibling::td[contains(@class,'status')]//div[@class='status-tag']");
    }

    public static Target NUMBER_PURCHASE(String number) {
        return Target.the("Number purchase request in list result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + number + "']");
    }

    /**
     * General information
     */
    public static Target PURCHASE_NUMBER_DETAIL = Target.the("Purchase number request in detail")
            .locatedBy("(//div[@class='page-header']//div[@class='title']//span)[1]");

    public static Target STORE_PURCHASE_DETAIL = Target.the("Store of purchase number request in detail")
            .locatedBy("//dd[@class='store-name']");

    public static Target ADMIN_NOTE_PURCHASE_DETAIL = Target.the("Admin note of purchase number request in detail")
            .locatedBy("//*[@class='admin-notes']");

    public static Target ADMIN_USER_PURCHASE_DETAIL = Target.the("Admin user of purchase number request in detail")
            .locatedBy("//*[@class='admin-user']");

    public static Target BUYER_PURCHASE_DETAIL = Target.the("Buyer of purchase number request in detail")
            .locatedBy("//*[@class='buyer-name']");

    public static Target BUYER_EMAIL_PURCHASE_DETAIL = Target.the("Buyer email of purchase number request in detail")
            .locatedBy("//*[@class='buyer-email']/a");

    public static Target RETAIL_PARTNER_PURCHASE_DETAIL = Target.the("Retail partner of purchase number request in detail")
            .locatedBy("//*[@class='is-current-retail-partner']/span");

    public static Target STATUS_PURCHASE_DETAIL = Target.the("Status of purchase number request in detail")
            .locatedBy("//dd//div[@class='status-tag']");

    public static Target STATUS_ICON_HISTORY_DETAIL = Target.the("Status icon history of purchase number request in detail")
            .locatedBy("//span[text()='Status']/following-sibling::span[@class='help-icon popover']");

    public static Target ADMIN_NOTE_PURCHASE_EDIT_DETAIL = Target.the("Admin note of purchase number request in detail")
            .locatedBy("//*[@class='admin-notes']/parent::div");

    public static Target ADMIN_USER_PURCHASE_EDIT_DETAIL = Target.the("Admin user of purchase number request in detail")
            .locatedBy("//*[@class='admin-user']/parent::div");

    public static Target DELETE_PURCHASE_BUTTON_EDIT_DETAIL = Target.the("Delete button purchase number request in detail")
            .locatedBy("(//div[@class='actions']//button[contains(@class,'el-button el-button--danger')])[1]");



    /**
     * Requested items
     */

    public static Target SKU_ID_REQUESTED_ITEMS(String skuID) {
        return Target.the("Sku id of requested items")
                .locatedBy("//div[contains(@class,'item-code')]//span[text()='" + skuID + "']");
    }

    public static Target SKU_REQUESTED_ITEMS(String skuID) {
        return Target.the("Sku of requested items")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='variant']");
    }

    public static Target BRAND_REQUESTED_ITEMS(String skuID) {
        return Target.the("Brand of requested items")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/preceding-sibling::td[@class='brand']/div");
    }

    public static Target PRODUCT_REQUESTED_ITEMS(String skuID) {
        return Target.the("Product of requested items")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/preceding-sibling::td[@class='product']/div");
    }

    public static Target BRAND_LINK_REQUESTED_ITEMS(String skuID) {
        return Target.the("Brand link of requested items")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/preceding-sibling::td[@class='brand']/div/a");
    }

    public static Target PRODUCT_LINK_REQUESTED_ITEMS(String skuID) {
        return Target.the("Product link of requested items")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::td/preceding-sibling::td[@class='product']/div/a");
    }
}

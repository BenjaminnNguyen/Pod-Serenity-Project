package cucumber.user_interface.beta.Vendor.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class VendorDisposeDonatePage {

    public static Target REQUEST_NUMBER = Target.the("Request id")
            .locatedBy("//h1[@class='page__title']");

    public static Target DISPOSE_DONATE_INVENTORY_TAB = Target.the("Dispose / donate inventory page")
            .locatedBy("//a[contains(text(),'Dispose / Donate Inventory')]");

    public static Target DISPOSE_DONATE_INVENTORY_SUB_TAB(String title) {
        return Target.the("Dispose / donate inventory page sub tab " + title)
                .locatedBy("//div[@class='entity-header']//span[text()='" + title + "']");
    }

    public static Target CREATE_REQUEST_BUTTON = Target.the("Create request button")
            .locatedBy("//a//span[text()='Request']");

    /**
     * Request Dispose / Donate list result
     */
    public static Target RESULT_VALUE(String value) {
        return Target.the(value + " in result")
                .locatedBy("//div[contains(@class,'" + value + "')]/div[@class='value']");
    }

    public static Target RESULT_NUMBER(String value) {
        return Target.the(value + " in result")
                .locatedBy("//div[contains(@class,'number')]/div[contains(text(),'" + value + "')]");
    }

    public static Target RESULT_STATUS = Target.the("Status request in result")
            .locatedBy("//div[contains(@class,'actions')]//div[@class='status-tag']");

    /**
     * Request Dispose / Donate
     */
    public static Target REQUEST_TITLE = Target.the("Request Dispose / Donate title")
            .locatedBy("//h1[text()='Request Dispose / Donate']");

    public static Target DISPOSE_OR_DONATE_TEXTBOX = Target.the("Dispose / Donate textbox")
            .locatedBy("//label[text()='Donate or Dispose']/following-sibling::div//input");

    public static Target REGION_TEXTBOX = Target.the("Region textbox")
            .locatedBy("//label[text()='Pickup region']/following-sibling::div//input");

    public static Target COMMENT_TEXTBOX = Target.the("Comment textbox")
            .locatedBy("//label[text()='Comment']/following-sibling::div//input");

    public static Target FEE_DONATION = Target.the("FEE_DONATION")
            .locatedBy("//p[@class='el-alert__description']//dd[1]");

    public static Target FEE_DISPOSAL = Target.the("FEE_DONATION")
            .locatedBy("//p[@class='el-alert__description']//dd[2]");

    /**
     * Request Dispose / Donate - Add new inventory
     */

    public static Target ADD_NEW_INVENTORY_POPUP = Target.the("Add new inventory popup")
            .locatedBy("//div[@role='dialog']//span[contains(@class,'title')]");

    public static Target ADD_NEW_INVENTORY_TEXTBOX = Target.the("Add new inventory textbox")
            .locatedBy("//div[@class='filters']//input");

    public static Target INVENTORY_LOTCODE(String lotcode) {
        return Target.the("Lotcode of inventory")
                .locatedBy("//div[contains(@class,'lot__code')]//div[text()='" + lotcode + "']");
    }

    public static Target INVENTORY_SELECT_CHECKBOX(String lotcode) {
        return Target.the("Lotcode of inventory")
                .locatedBy("//div[text()='" + lotcode + "']/parent::div/preceding-sibling::div");
    }

    public static Target ADD_NEW_INVENTORY_BUTTON = Target.the("Add new inventory button")
            .locatedBy("//div[@role='dialog']//button//span[contains(text(),'Add')]");

    /**
     * Request Dispose / Donate - After add inventory
     */

    public static Target INVENTORY_OF_CASE_TEXTBOX(String lotcode) {
        return Target.the("Inventory of case textbox")
                .locatedBy("//div[text()='" + lotcode + "']//ancestor::div[@class='lot__code']/following-sibling::div[@class='lot__quantity']//input");
    }

    public static Target INVENTORY_MAX_CASE_TEXTBOX(String lotcode) {
        return Target.the("Inventory max textbox")
                .locatedBy("//div[text()='" + lotcode + "']//ancestor::div[@class='lot__code']/following-sibling::div[@class='lot__remaining']//button/span");
    }

    /**
     * Request Dispose / Donate - Detail - SKU
     */

    public static Target REQUEST_STATUS = Target.the("Request status")
            .locatedBy("//div[@class='status-tag bordered']");

    public static Target INVENTORY_PRODUCT(String lotcode) {
        return Target.the("Product of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/preceding-sibling::div/div[contains(@class,'product')]");
    }

    public static Target INVENTORY_BRAND(String lotcode) {
        return Target.the("Brand of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/preceding-sibling::div/div[contains(@class,'brand')]");
    }

    public static Target INVENTORY_SKU(String lotcode) {
        return Target.the("Sku of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/preceding-sibling::div/div[contains(@class,'sku')]");
    }

    public static Target INVENTORY_SKU_ID(String lotcode) {
        return Target.the("Sku id of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/preceding-sibling::div/div[contains(@class,'product-variant-stamp')]//div[contains(@class,'id')]");
    }

    public static Target INVENTORY_EXPIRY_DATE(String lotcode) {
        return Target.the("Expiry date of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/following-sibling::div[@class='lot__expiry']/div[contains(@class,'lot__value')]");
    }

    public static Target INVENTORY_PULL_DATE(String lotcode) {
        return Target.the("Pull of inventory with lotcode " + lotcode)
                .locatedBy("//div[text()='" + lotcode + "']//parent::div/following-sibling::div[@class='lot__pull']/div[contains(@class,'lot__value')]");
    }
}

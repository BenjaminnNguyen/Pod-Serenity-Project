package cucumber.user_interface.admin.inventory.disposeDonateRequest;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class InventoryRequestPage {
    public static Target RESULT_NUMBER(String number) {
        return Target.the("Result number")
                .located(By.xpath("//a[text()='" + number + "']"));
    }

    public static Target RESULT_REQUEST_DATE = Target.the("Result request date")
            .located(By.xpath("(//span[@class='request-date'])[1]"));

    public static Target RESULT_VENDOR_COMPANY = Target.the("Result vendor company")
            .located(By.xpath("(//div[@class='link-tag']/span)[1]"));

    public static Target RESULT_BRAND = Target.the("Result brand")
            .located(By.xpath("(//td[contains(@class,'brand')]//span)[1]"));

    public static Target RESULT_REGION = Target.the("Result region")
            .located(By.xpath("(//td[contains(@class,'region')]//span)[1]"));

    public static Target RESULT_TYPE = Target.the("Result type")
            .located(By.xpath("(//td[contains(@class,'type')]//span)[1]"));

    public static Target RESULT_STATUS = Target.the("Result status")
            .located(By.xpath("(//td[contains(@class,'status')]//div/div)[1]"));

    /**
     * Create Inventory request
     */

    public static Target CREATE_REQUEST_BUTTON = Target.the("Create request button")
            .located(By.xpath("//div[@class='page-header']//button//span[text()='Create']"));

    public static Target CREATE_FORM_HEADER = Target.the("Create request form header")
            .located(By.xpath("//span[text()='New Dispose / Donate Inventories']"));

    public static Target VENDOR_COMPANY_TEXTBOX = Target.the("Vendor company textbox")
            .located(By.xpath("//label[text()='Vendor Company']/following-sibling::div//input"));

    public static Target REGION_TEXTBOX = Target.the("Region textbox")
            .located(By.xpath("//label[text()='Region']/following-sibling::div//input"));

    public static Target TYPE_CHECKBOX(String type) {
        return Target.the("Type checkbox")
                .located(By.xpath("//label[text()='Type']//following-sibling::div//span[text()='" + type + "']"));
    }

    public static Target COMMENT_TEXTAREA = Target.the("Comment textbox")
            .located(By.xpath("//label[text()='Note']/following-sibling::div//textarea"));

    // Error message

    public static Target D_CREATE_ERROR_MESSAGE(String title) {
        return Target.the("Vendor company error message")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div/div[contains(@class,'error')]"));
    }

    /**
     * Create Inventory request - Popup add pullable inventory
     */
    public static Target ADD_PULLABLE_INVENTORY_POPUP = Target.the("add pullable inventory popup")
            .located(By.xpath("//div[@role='dialog']//span[text()='Add pullable Inventory']"));

    public static Target D_ADD_LOTCODE(String field) {
        return Target.the(field + " information")
                .located(By.xpath("//div[@role='dialog']//label[contains(normalize-space(),'" + field + "')]//following-sibling::div//input"));
    }

    public static Target SEARCH_RESULTS(String field, int i) {
        return Target.the(field + " information")
                .locatedBy("(//div[@role='dialog']//table[contains(@class,'pullable-inventory-table')]//td[contains(@class,'" + field + "')])[" + i + "]");
    }

    public static Target SEARCH_LOT_CODE_BUTTON = Target.the("search lot code")
            .locatedBy("//span[contains(text(),'Search')]");

    public static Target LOT_CODE_CHECKBOX(String info) {
        return Target.the("lot code")
                .located(By.xpath("//div[@role='dialog']//td[contains(text(),'" + info + "')]/preceding-sibling::td[@class='section']"));
    }

    public static Target FIRST_LOT_CODE = Target.the("first lot")
            .locatedBy("//td[@class='sku-name tl']/preceding-sibling::td[@class='section']");

    public static Target ADD_LOT_CODE_BUTTON_IN_POPUP = Target.the("Add lot code")
            .locatedBy("//button//span[text()='Add']");

    public static Target CASES(String lot) {
        return Target.the("case lot code")
                .located(By.xpath("//*[normalize-space()='" + lot + "']/parent::td/following-sibling::td[@class='case']//input"));
    }

    public static Target REMOVE_INVENTORY_BUTTON(String lot) {
        return Target.the("Remove inventory button")
                .located(By.xpath("//*[normalize-space()='" + lot + "']/parent::td/following-sibling::td[@class='action']//button"));
    }

    /**
     * Inventory request detail - General information
     */

    public static Target GENERAL_INFORMATION_DETAIL(String title) {
        return Target.the("General information of " + title)
                .locatedBy("//span[@class='" + title + "']");
    }

    public static Target GENERAL_INFORMATION_STATUS = Target.the("General information of status")
            .locatedBy("//div[@class='status-tag status']");

    public static Target GENERAL_INFORMATION_COMMENT = Target.the("General information of comment")
            .locatedBy("//dt[text()='Comment']/following-sibling::dd//div[contains(@class,'content')]/span");


    /**
     * Inventory request detail - Pullable Inventories
     */

    public static Target PULLABLE_LOTCODE(String lotCode) {
        return Target.the("Pullable inventory of " + lotCode)
                .locatedBy("//td[@class='lot-code']//a[text()='" + lotCode + "']");
    }

    public static Target PULLABLE_BRAND(String lotCode) {
        return Target.the("Brand of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/preceding-sibling::td[@class='brand-name']");
    }

    public static Target PULLABLE_PRODUCT(String lotCode) {
        return Target.the("Product of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/preceding-sibling::td[@class='product-name']");
    }

    public static Target PULLABLE_SKU(String lotCode) {
        return Target.the("Sku of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/preceding-sibling::td[@class='sku-name']//span[@class='name']");
    }

    public static Target PULLABLE_SKU_ID(String lotCode) {
        return Target.the("Sku id of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/preceding-sibling::td[@class='sku-name']//span[contains(@class,'item-code-tag')]");
    }

    public static Target PULLABLE_EXPIRY_DATE(String lotCode) {
        return Target.the("Expiry of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/following-sibling::td[@class='expiry-date']");
    }

    public static Target PULLABLE_PULL_DATE(String lotCode) {
        return Target.the("Pulldate of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/following-sibling::td[@class='expiry-date']");
    }

    public static Target PULLABLE_CASE(String lotCode) {
        return Target.the("Case of pullable inventory with lotcode " + lotCode)
                .locatedBy("//*[text()='" + lotCode + "']/parent::td/following-sibling::td[@class='case']//input");
    }
}

package cucumber.user_interface.admin.promotion;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllPromotionsPage {

    /**
     * Dialog Create Promotion
     */
    public static final Target CREATE_BUTTON = Target.the("'Create Promotion Button'")
            .locatedBy("//button//span[text()='Create']");

    public static final Target UPDATE_BUTTON = Target.the("'Update Promotion Button'")
            .locatedBy("//span[contains(text(),'Update')]/ancestor::button");

    public static final Target INCLUDED_STORES = Target.the("'Create Promotion Button'")
            .locatedBy("//label[normalize-space()='Included stores']");

    public static Target DYNAMIC_TYPE_PROMO(String type) {
        return Target.the("Type promo " + type)
                .locatedBy("//div[@role='radiogroup']//span[contains(text(),'" + type + "')]");
    }

    public static Target DYNAMIC_TEXTBOX(String name) {
        return Target.the("Textbox " + name)
                .locatedBy("//div[@class='el-dialog__body']//label[normalize-space()='" + name + "']/following-sibling::div//input|//div[@class='el-dialog__body']//label[normalize-space()='" + name + "']/following-sibling::div//textarea");
    }


    public static Target DYNAMIC_TEXT_BOX_ERROR(String name) {
        return Target.the("Label error of " + name)
                .locatedBy("//div[@class='el-dialog__body']//label[normalize-space()='" + name + "']/following-sibling::div/div[@class='el-form-item__error']");
    }


    public static Target DYNAMIC_INFO_ERROR(String title) {
        return Target.the("Information of " + title + " error")
                .located(By.xpath("//label[contains(text(),'" + title + "')]/following-sibling::div//div[contains(@class,'item__error')]"));
    }

    public static Target DYNAMIC_TEXTAREA(String name) {
        return Target.the("Textbox " + name)
                .locatedBy("//div[@class='el-dialog__body']//label[normalize-space()='" + name + "']/following-sibling::div//textarea");
    }

    public static final Target SHOW_VENDOR_SWITCH = Target.the("'Show Vendor switch'")
            .locatedBy("//div[@role='switch']");
    public static final Target PROMO_NAME = Target.the("PROMO_NAME")
            .locatedBy("//div[contains(@class,'el-form-item name')]//input");
    public static final Target CASE_LIMIT = Target.the("CASE_LIMIT")
            .locatedBy("//div[contains(@class,'el-form-item case-limit')]//input");
    public static final Target USAGE_LIMIT = Target.the("USE_LIMIT")
            .locatedBy("//div[contains(@class,'el-form-item usage-limit')]//input");
    public static final Target REGIONAL_PROMOTION = Target.the("REGIONAL_PROMOTION")
            .locatedBy("//label[normalize-space()='Regional promotion']/following-sibling::div/div");

    public static final Target PROMOTION_NOTE = Target.the("PROMOTION_NOTE")
            .locatedBy("//div[@class='el-dialog__body']//label[normalize-space()='Note']/following-sibling::div//textarea");

    public static Target APPLIED_REGION(String region) {
        return Target.the("APPLIED_REGION")
                .locatedBy("//span[contains(text(),'" + region + "')]/ancestor::label");
    }

    public static final Target CREATE_BY = Target.the("CREATE_BY")
            .locatedBy("//div[@class='el-form-item name is-required el-form-item--small']/preceding-sibling::div");

    public static Target DYNAMIC_ITEM_DROPDOW(String skuName) {
        return Target.the("Item " + skuName + " in dropdown")
                .locatedBy("//div[@class='el-scrollbar']//div[text()='" + skuName + "']");
    }

    public static Target DYNAMIC_ITEM_DROPDOW_STORE(String storeName) {
        return Target.the("Item " + storeName + " in dropdown")
                .locatedBy("(//div[@x-placement]//div[@class='el-scrollbar']//span[text()='" + storeName + "'])[last()]");
    }

    public static Target SKU_CHECKBOX(String sku) {
        return Target.the("SKU " + sku)
                .locatedBy("//span[contains(@data-original-text,'" + sku + "')]/ancestor::td/preceding-sibling::td//label");
    }

    public static Target INCLUDED_BUYER_COMPANY(String buyer) {
        return Target.the("BUYER " + buyer)
                .locatedBy("//div[contains(@class,'included-buyer-companies')]//div[text()='" + buyer + "']");
    }

    public static Target EXCLUDED_BUYER_COMPANY(String buyer) {
        return Target.the("BUYER " + buyer)
                .locatedBy("//div[contains(@class,'excluded-buyer-companies')]//div[text()='" + buyer + "']");
    }

    public static Target INCLUDED_STORE(String buyer) {
        return Target.the("BUYER " + buyer)
                .locatedBy("//div[contains(@class,'included-stores')]//div[text()='" + buyer + "']");
    }

    public static Target EXCLUDED_STORE(String buyer) {
        return Target.the("BUYER " + buyer)
                .locatedBy("//div[contains(@class,'excluded-stores')]//div[text()='" + buyer + "']");
    }

    public static Target RULE_TYPE_PROMO(String ruleType) {
        return Target.the("Rule type promo " + ruleType)
                .locatedBy("//div[contains(@class,'rule-type')]//span[text()='" + ruleType + "']");
    }

    public static Target DYNAMIC_REGION(String region) {
        return Target.the("Region  " + region)
                .locatedBy("//label[normalize-space()='Regions']/following-sibling::div//span[text()='" + region + "']");
    }

    public static Target REGION_CHECKBOX(String region) {
        return Target.the("Region  " + region)
                .locatedBy("//span[text()='" + region + "']/ancestor::label[contains(@class,'checkbox')]");
    }

    public static Target DYNAMIC_BUTTON(String buttonName) {
        return Target.the("Button  " + buttonName)
                .locatedBy("//div[@role='dialog']//button//span[text()='" + buttonName + "']");
    }

    public static Target OVERLAP_PROMO_DIALOG = Target.the("Overlapping promotion dialog")
            .locatedBy("//div//span[text()='Overlapping promotion']");

    public static Target PROCESS_BUTTON = Target.the("Button Process")
            .locatedBy("//div//span[contains(text(),'Proceed')]");

    public static Target DUPLICATE_BUTTON = Target.the("Button Process")
            .locatedBy("//button[contains(@type,'button')]//span//span[contains(text(),'Duplicate')]");

    public static Target DELETE_BUTTON = Target.the("Button Process")
            .locatedBy("//button[contains(@type,'button')]//span//span[contains(text(),'Duplicate')]");

    public static Target TYPE_PROMO_ACTIVE = Target.the("Type promo active")
            .locatedBy("//span[text()=' TPR']//ancestor::label[contains(@class,'el-radio-button el-radio-button--small is-active')]");

    public static Target AMOUNT_TYPE = Target.the("AMOUNT_TYPE")
            .locatedBy("//label[normalize-space()='Amount']/following-sibling::div//span");


    public static Target STACK_DEAL_CHECKED = Target.the("STACK_DEAL_CHECKED")
            .locatedBy("//label[normalize-space()='Is this a case stack deal?']/following-sibling::div//div[@role='switch']");


    public static Target STACK_DEAL_INFO(int i, String field) {
        return Target.the("MIN_QUANTITY " + i)
                .locatedBy("(//label[normalize-space()='" + field + "']/following-sibling::div//input)[" + i + "]");
    }

    public static Target STACK_DEAL_DES(int i) {
        return Target.the("Amount " + i)
                .locatedBy("(//p[@class='el-alert__description']//span[contains(text(),'Quantity ')]/parent::div)[" + i + "]");
    }

    public static Target STACK_DEAL_DELETE(String i) {
        return Target.the("Amount " + i)
                .locatedBy("(//div[@class='el-row']//div[@class='actions'])[" + i + "]");
    }

    public static Target STACK_DEAL_HELP(int i) {
        return Target.the("Amount " + i)
                .locatedBy("(//div[@class='help'])[" + i + "]|(//div[contains(@class,'stack-form-item')]//legend)[" + i + "]");
    }


    /**
     * Table all promotion
     */

    public static Target PROMOTION_NAME_IN_RESULT(String promoName) {
        return Target.the("Promo name  " + promoName)
                .locatedBy("//td[contains(@class,'name')]//div[text()='" + promoName + "']");
    }

    public static Target DELETE_PROMOTION_NAME(String promoName) {
        return Target.the("Promo name  " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td[contains(@class,'name')]/following-sibling::td[contains(@class,'actions')]//button[last()]");
    }

    public static Target TYPE_IN_RESULT(String promoName) {
        return Target.the("Type of promo " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td/following-sibling::td//div[contains(@class,'type')]");
    }

    public static Target REGION_IN_RESULT(String promoName) {
        return Target.the("Region of promo " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td/following-sibling::td[contains(@class,'region')]/div");
    }

    public static Target START_IN_RESULT(String promoName) {
        return Target.the("Start at of promo " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td/following-sibling::td[contains(@class,'starts-at')]");
    }

    public static Target EXPIRE_IN_RESULT(String promoName) {
        return Target.the("Expire at of promo " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td/following-sibling::td[contains(@class,'expires-at')]");
    }
    public static Target MANAGED_IN_RESULT(String promoName) {
        return Target.the("Expire at of promo " + promoName)
                .locatedBy("//div[text()='" + promoName + "']/ancestor::td/following-sibling::td[contains(@class,'managed-by')]");
    }

    public static final Target SHOW_VENDOR_SWITCH_DETAILS = Target.the("'Show Vendor switch detail'")
            .locatedBy("//div[@role='switch']");


    public static final Target FROM_DATE = Target.the("'FROM_DATE'")
            .locatedBy("//div[@class='el-dialog__body']//*[normalize-space()='From']//ancestor::div[contains(@class,'from-date')]//input");

    public static final Target TO_DATE = Target.the("'FROM_DATE'")
            .locatedBy("//div[@class='el-dialog__body']//*[normalize-space()='To']//ancestor::div[contains(@class,'to-date')]//input");

    public static final Target APPROVED_BY = Target.the("'APPROVED_BY'")
            .locatedBy("//span[contains(@class,'approved-by')]");

    public static final Target INVENTORY_INPUT = Target.the("INVENTORY_INPUT")
            .locatedBy("//input[@placeholder='Search for lotcode, brand, product or SKU name']");


    public static Target PROMOTION_TYPE(String type) {
        return Target.the("SKU added in promo")
                .locatedBy("(//span[contains(text(),'" + type + "')])/ancestor::label[@aria-disabled='true']/input");
    }


    public static Target SKU_DETAILS(String sku) {
        return Target.the("SKU added in promo")
                .locatedBy("//div[@class='item']//div[normalize-space()='" + sku + "']");
    }

    public static Target INVENTORY_LINK(String lot) {
        return Target.the("INVENTORY_LINK")
                .locatedBy("//a[@class='lot-code-link']/span[contains(text(),'" + lot + "')]");
    }

    public static Target ITEM(String sku, String class_) {
        return Target.the("SKU added in promo")
                .locatedBy("//span[contains(@data-original-text,'" + sku + "')]//ancestor::div[@class='info']/div[@class='" + class_ + "']/span");
    }

    public static Target NO_DATA_RESULT = Target.the("Text no data")
            .locatedBy("//span[text()='No Data']");

    /**
     * Thanh phân trang
     */

    public static Target NEXT_PAGE_BUTTON = Target.the("Next page button")
            .locatedBy("//button[@class='btn-next']");

    public static Target PREVIOUS_PAGE_BUTTON = Target.the("Previous page button")
            .locatedBy("//button[@class='btn-prev']");

    public static Target PREVIOUS_PAGE_BUTTON_DISABLED = Target.the("Previous page button disabled")
            .locatedBy("//button[@class='btn-prev' and @disabled='disabled']");
    public static Target NUMBER_ACTIVE = Target.the("Previous page button")
            .locatedBy("(//li[@class='number active'])[last()]");
    public static Target NUMBER_TOTAL = Target.the("Previous page button")
            .locatedBy("//strong[@class='total']");

    public static Target NUMBER_PAGE(String page) {
        return Target.the("Button page")
                .locatedBy("//li[@class='number' and text()='" + page + "']");
    }

    public static Target DELETE_STORE(String st) {
        return Target.the("Delete store")
                .locatedBy("//div[contains(text(),'" + st + "')]/parent::div/following-sibling::div");
    }

    public static Target DELETE_EXCLUDED(String field, String st) {
        return Target.the("Delete store")
                .locatedBy("//label[normalize-space()='" + field + "']/following-sibling::div//div[contains(text(),'" + st + "')]/parent::div/following-sibling::div");
    }
}

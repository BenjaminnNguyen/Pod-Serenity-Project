package cucumber.user_interface.beta.Vendor.inventory;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class VendorWithdrawalRequestPage {
    public static Target LOADING_SPIN = Target.the("")
            .locatedBy("//div[@class='loading--indicator']");
    public static Target TITLE = Target.the("")
            .locatedBy("//h1[@class='page__title']");

    public static Target DYNAMIC_TAB(String tabName) {
        return Target.the("Tab " + tabName)
                .locatedBy("//div[@class='label']//span[contains(text(),'" + tabName + "')]");
    }

    public static Target RECORD(String num, String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(text(),'" + num + "')]/ancestor::a[@class='edt-row record']/div[contains(@class,'" + s + "')]/*[2]");
    }

    public static Target NUMBER(String number) {
        return Target.the("")
                .locatedBy("//div[@class='md focus' and text()='" + number + "']");
    }

    public static Target NUMBER_PAGE = Target.the("Number page")
            .locatedBy("//li[contains(@class,'number')]");


    /**
     * Withdrawal Requests Detail
     */
    public static Target DYNAMIC_FIELD(String s) {
        return Target.the(s)
                .locatedBy("//label[normalize-space()='" + s + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_FIELD_ERROR(String s) {
        return Target.the(s)
                .locatedBy("//label[normalize-space()='" + s + "']/following-sibling::div/div[contains(@class,'error')]");
    }

    public static Target PICKUP_DATE_DAY_DISABLE(String day) {
        return Target.the("Day disable")
                .locatedBy("//td[@class='normal disabled']//span[contains(text(),'" + day + "')]");
    }

    public static Target DYNAMIC_SKU(int i, String s) {
        return Target.the(s)
                .locatedBy("(//div[contains(text(),'" + s + "')])[" + i + "]");
    }

    public static Target DYNAMIC_SKU_BY_LOTCODE(String lotCode) {
        return Target.the("Check box with lotcote " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div[@class='lot__select']");
    }

    public static Target LOT_QUANTITY(int i) {
        return Target.the("")
                .locatedBy("(//input[@role='spinbutton'])[" + i + "]");
    }

    public static Target NO_RESULTS_FOUND = Target.the("No results found")
            .located(By.xpath("//span[normalize-space()='No sample requests found...']"));

    public static Target LIST_REGION = Target.the("List region")
            .located(By.xpath("//div[contains(@class,'region')]//ul/li//span"));

    public static Target STATUS = Target.the("Status")
            .located(By.xpath("//div[@class='status-tag bordered']"));

    public static Target BOL = Target.the("BOL")
            .located(By.xpath("//div[@class='files__item-name pf-ellipsis']"));

    public static Target LOT_QUANTITY = Target.the("lot quantity")
            .located(By.xpath("//input[@role='spinbutton']"));

    public static Target LOT_REMAINING = Target.the("lot quantity")
            .located(By.xpath("//div[@class='lot__remaining']//strong"));

    public static Target CREATE_WITHDRAWAL_REQUEST = Target.the("CREATE_WITHDRAWAL_REQUEST")
            .located(By.xpath("//span[normalize-space()='Request Withdrawal']"));

    public static Target MESSAGE_LOT_ERROR = Target.the("Message lot code error")
            .located(By.xpath("//span[contains(text(),'Add new inventory')]/ancestor::button/following-sibling::div"));

    public static Target ADD_NEW_LOT = Target.the("ADD NEW LOT")
            .located(By.xpath("//span[contains(text(),'Add new inventory')]/ancestor::button"));

    public static Target ADD_NEW_LOT_DISABLED = Target.the("ADD NEW LOT")
            .located(By.xpath("//span[contains(text(),'Add new inventory')]/ancestor::button[contains(@class,'disabled')]"));
    public static Target FIND_LOT = Target.the("")
            .located(By.xpath("//div[@class='filter']//input[@type='text']"));

    public static Target ADD_SELECTED_LOT = Target.the("")
            .located(By.xpath("//span[@class='dynamic-btn-content']"));

    public static Target END_QUANTITY_OF_SKU = Target.the("End quantity of sku")
            .located(By.xpath("//div[@class='lot__end-qty tr']//div[@class='lot__value']"));

    public static Target UPLOAD_BOL = Target.the("upload bol")
            .located(By.xpath("//input[@type='file']"));

    public static Target CREATE_BUTTON = Target.the("CREATE")
            .located(By.xpath("//span[normalize-space()='Create']"));

    public static Target ADDRESS = Target.the("ADDRESS")
            .located(By.xpath("//div[@class='pickup-address flex']"));

    public static Target END_QUANTITY_OF_SKU(String sku) {
        return Target.the("End quantity of sku " + sku)
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[@class='lot__end-qty tr']//div[@class='lot__value']"));

    }

    public static Target LOT_QUANTITY_FIELD(String sku) {
        return Target.the("lot quantity " + sku)
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[@class='lot__quantity']//input"));

    }

    /**
     * Withdrawal Details SKU Info
     */

    public static Target INSTRUCTIONS = Target.the("CREATE")
            .located(By.xpath("//div[@class='instructions']"));


    public static Target D_BRAND_DETAILS(String lotCode) {
        return Target.the("Brand of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'brand')]");
    }

    public static Target SEARCH_VALUE(String class_, int i) {
        return Target.the(class_ + " of lot code ")
                .locatedBy("(//div[@aria-label='Add new inventory']//div[@class='" + class_ + "'])[" + i + "]");
    }

    public static Target SEARCH_VALUE_LOT(String lot) {
        return Target.the("Brand of lot code ")
                .locatedBy("(//div[@aria-label='Add new inventory']//div[@class='lot__value pf-break-word' and text()='" + lot + "'])");
    }

    public static Target D_PRODUCT_DETAILS(String lotCode) {
        return Target.the("Product of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'product pf')]");
    }

    public static Target D_SKU_DETAILS(String lotCode) {
        return Target.the("SKU of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'sku')]");
    }

    public static Target SKU_ADDED(String lotCode) {
        return Target.the("SKU of lotcode " + lotCode)
                .locatedBy("(//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div[@class='lot__select']/label)[last()]");
    }

    public static Target D_SKU_ID_DETAILS(String lotCode) {
        return Target.the("SKU ID of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div//div[contains(@class,'variant__id')]");
    }

    public static Target D_LOTCODE_DETAILS(String lotCode) {
        return Target.the("Lotcode")
                .locatedBy("//div[text()='" + lotCode + "']");
    }

    public static Target D_QUANTITY_DETAILS(String lotCode) {
        return Target.the("Quantity of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/following-sibling::div[contains(@class,'lot__quantity')]//input");
    }

    public static Target D_MAX_DETAILS(String lotCode) {
        return Target.the("Max of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/following-sibling::div[contains(@class,'lot__remaining')]//button");
    }

    public static Target D_DELETE_DETAILS(String lotCode) {
        return Target.the("Delete of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/following-sibling::div[contains(@class,'lot__actions')]//button");
    }

}

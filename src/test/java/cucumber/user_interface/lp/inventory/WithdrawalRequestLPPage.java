package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class WithdrawalRequestLPPage {
    /**
     * Search in header
     */
    public static Target D_FIELD_SEARCH(String name) {
        return Target.the("Field " + name + " search")
                .locatedBy("//label[text()='" + name + "']/following-sibling::div//input");
    }

    /**
     * Loading Icon
     */
    public static Target LOADING_ICON = Target.the("Loading icon")
            .locatedBy("//div[@class='loading--indicator']");

    /**
     * Table result of search
     */

    public static Target NO_FOUND_RESULT = Target.the("No found result")
            .locatedBy("//div//span[text()='No withdrawal requests found...']");

    public static Target NUMBER_RESULT(String number) {
        return Target.the("Number of result")
                .locatedBy("//div[contains(@class,'number')]//div[contains(text(),'" + number + "')]");
    }

    public static Target BRAND_RESULT(String number) {
        return Target.the("Brand of result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'request-date')]/div[2]");
    }

    public static Target PICKUPDATE_RESULT(String number) {
        return Target.the("Pickup date of result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'pickup-date')]/div[2]");
    }

    public static Target STATUS_RESULT(String number) {
        return Target.the("Status date of result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'status')]/div/div");
    }

    /**
     * Withdrawal Requests Details - Pickup Information
     */

    public static Target REQUEST_HEADER_DETAIL = Target.the("Request header details")
            .locatedBy("//h1[contains(text(),'Request')]");

    public static Target STATUS_DETAIL = Target.the("Status of withdrawal request")
            .locatedBy("//div[@class='page__actions']/div");

    public static Target D_TEXTBOX_DETAIL(String title) {
        return Target.the("Textbox " + title)
                .locatedBy("//label[contains(text(),'" + title + "')]/following-sibling::div//input");
    }

    public static Target D_TEXTBOX_BOL_DETAIL(String title) {
        return Target.the("Textbox BOL" + title)
                .locatedBy("//label[contains(text(),'" + title + "')]/following-sibling::div//strong");
    }

    /**
     * Withdrawal Requests Details - Withdrawal Details
     */

    public static Target D_BRAND_DETAILS(String lotCode) {
        return Target.the("Brand of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'brand')]");
    }

    public static Target D_PRODUCT_DETAILS(String lotCode) {
        return Target.the("Product of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'product pf')]");
    }

    public static Target D_SKU_DETAILS(String lotCode) {
        return Target.the("SKU of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/preceding-sibling::div/div[contains(@class,'sku')]");
    }

    public static Target D_LOTCODE_DETAILS(String lotCode) {
        return Target.the("Lotcode")
                .locatedBy("//div[text()='" + lotCode + "']");
    }

    public static Target D_QUANTITY_DETAILS(String lotCode) {
        return Target.the("Quantity of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/following-sibling::div[contains(@class,'lot__quantity')]//input");
    }

    public static Target D_EXPIRY_DATE_DETAILS(String lotCode) {
        return Target.the("Expiry date of lotcode " + lotCode)
                .locatedBy("//div[text()='" + lotCode + "']/parent::div/following-sibling::div[contains(@class,'lot__expiry_date')]//input");
    }

    public static Target PALLET_TEXTBOX = Target.the("Pallet textbox")
            .locatedBy("//label[text()='Pallet weight in total']/following-sibling::div//input");

    public static Target COMMENT_TEXTBOX = Target.the("Comment textbox")
            .locatedBy("//label[text()='Comment']/following-sibling::div//input");

    public static Target BOL_FILE = Target.the("Bol file")
            .locatedBy("//label[text()='Upload BOL']/following-sibling::div//a/div[1]");

    /**
     * Withdrawal Requests Details - Withdrawal Details Error
     */

    public static Target D_TEXTBOX_DETAIL_ERROR(String title) {
        return Target.the("Field error " + title)
                .locatedBy("//label[contains(text(),'" + title + "')]/following-sibling::div/div[contains(@class,'error')]");
    }

    public static Target D_TEXTBOX_DETAIL_DISABLE(String title) {
        return Target.the("Textbox " + title)
                .locatedBy("//label[contains(text(),'" + title + "')]/following-sibling::div//input[@disabled='disabled']");
    }


    public static Target DONATE_INVENTORY_INFO(String number, String class_) {
        return Target.the("DONATE_INVENTORY_INFO " + number)
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'" + class_ + "')]/div[contains(@class,'value')]");
    }

    public static Target DONATE_INVENTORY_DETAIL_INFO(String class_) {
        return Target.the("DONATE_INVENTORY_INFO " + class_)
                .locatedBy("//div[contains(@class,'" + class_ + "')]/div[contains(@class,'value')]");
    }

    public static Target DONATE_INVENTORY_DETAIL_GENERAL_INFO(String field) {
        return Target.the("DONATE_INVENTORY_INFO " + field)
                .locatedBy("//dt[normalize-space()='" + field + "']/following-sibling::dd");
    }

    public static Target DONATE_INVENTORY_ITEMS(String lot, String class_) {
        return Target.the("DONATE_INVENTORY_INFO " + lot)
                .locatedBy("//div[contains(text(),'" + lot + "')]/ancestor::div[@class='lot']//div[contains(@class,'" + class_ + "')]");
    }

    public static Target DISPOSE_REQUEST_NUMBER = Target.the("Request id")
            .locatedBy("//h1[@class='page__title']");
}

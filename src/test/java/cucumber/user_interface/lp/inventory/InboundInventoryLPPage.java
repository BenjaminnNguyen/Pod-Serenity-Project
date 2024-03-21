package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class InboundInventoryLPPage {

    public static Target INBOUND_TAB = Target.the("Inbound inventory page")
            .locatedBy("//a[normalize-space()='Inbound Inventories']");

    public static Target NUMBER_SEARCH = Target.the("Number field")
            .locatedBy("//div[@class='filter-param field']/label[text()='Number']/following-sibling::div/input");

    public static Target LOADING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--layout']");


    public static Target NO_INVENTORY_FOUND = Target.the("No inventory found")
            .locatedBy("//span[normalize-space()='No inventories found...']");


    /*
     * Table
     * */
    public static Target TABLE_NUMBER(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='inventories-list']//div[@class='edt-piece number']/div[2])[" + i + "]");
    }

    public static Target TABLE_INFO(String num, String class_) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + num + "')]/parent::div/following-sibling::div[contains(@class,'" + class_ + "')]");
    }

    public static Target TABLE_NUMBER(String i) {
        return Target.the("")
                .locatedBy("//div[@class='edt-piece number']//div[normalize-space()='" + i + "']");
    }

    public static Target TABLE_BRAND(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='inventories-list']//div[@class='edt-piece brands']/div[2])[" + i + "]");
    }

    public static Target TABLE_ETA(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='inventories-list']//div[@class='edt-piece eta']/div[2])[" + i + "]");
    }

    public static Target ID_IN_RESULT(String id) {
        return Target.the("Record inbound by id")
                .locatedBy("//div[@class='page lp inventory']//div[text()='" + id + "']");
    }

}

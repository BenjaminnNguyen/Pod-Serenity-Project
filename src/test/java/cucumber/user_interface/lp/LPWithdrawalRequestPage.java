package cucumber.user_interface.lp;

import net.serenitybdd.screenplay.targets.Target;

public class LPWithdrawalRequestPage {

    public static Target ALL_TAB = Target.the("All inventory page")
            .locatedBy("//a[normalize-space()='All Inventory']");

    public static Target DYNAMIC_TABLE(String value, int i) {
        return Target.the(value)
                .locatedBy("(//div[@class='edt-piece " + value + "']/div[2])[" + i + "]");
    }

    public static Target DYNAMIC_SEARCH(String value) {
        return Target.the("")
                .locatedBy("//label[normalize-space()='" + value + "']/following-sibling::div//input");
    }
    public static Target LOADING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--layout']");

}

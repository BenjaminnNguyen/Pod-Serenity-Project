package cucumber.user_interface.beta.Vendor.payments;

import net.serenitybdd.screenplay.targets.Target;

public class VendorPaymentPage {

    /**
     * Summary tab
     */
    public static Target NUMBER(String id) {
        return Target.the("Number payment in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]");
    }

    public static Target STORE(String id) {
        return Target.the("Store payment in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]/parent::div/following-sibling::div[contains(@class,'store')]/div[2]");
    }

    public static Target ORDER_VALUE(String id) {
        return Target.the("Order value in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]/parent::div/following-sibling::div[contains(@class,'value')]/div[2]");
    }

    public static Target PAID(String id) {
        return Target.the("Paid to you in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]/parent::div/following-sibling::div[contains(@class,'paid')]/div[2]");
    }

    public static Target CREATE_DATE(String id) {
        return Target.the("Date of payment in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]/parent::div/following-sibling::div[contains(@class,'created')]/span");
    }

    /**
     * Monthly Statements
     */
    public static Target MONTHLY_STATEMENT = Target.the("Monthly statements tab")
            .locatedBy("//a[text()='Monthly Statements']");

    public static Target MONTH(String date) {
        return Target.the("Month")
                .locatedBy("//span[text()='" + date + "']");
    }

    public static Target NUMBER_MONTHLY(String id) {
        return Target.the("Number payment in summary tab")
                .locatedBy("//span[contains(text(),'" + id + "')]");
    }

}

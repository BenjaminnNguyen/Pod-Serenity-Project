package cucumber.user_interface.beta.Vendor.products;

import net.serenitybdd.screenplay.targets.Target;

public class VendorChangeRequestPage {

    public static Target SKU(String sku) {
        return Target.the("SKU " + sku).locatedBy("//div[@class='skus-list']//div[contains(text(),'" + sku + "')]");
    }

    public static Target SKU_CURRENT_VALUE(String field) {
        return Target.the("field " + field).locatedBy("//*[normalize-space()='" + field + "']/following-sibling::div//strong");
    }
    public static Target INPUT_VALUE(String field) {
        return Target.the("field " + field).locatedBy("(//*[contains(text(),\"" + field + "\")]/parent::label/following-sibling::div//input)");
    }
    public static Target AFTER_VALUE(String field) {
        return Target.the("field " + field).locatedBy("//*[normalize-space()='" + field + "']/parent::label/following-sibling::div//strong");
    }
    public static Target REGION_AFTER_VALUE(String field) {
        return Target.the("field " + field).locatedBy("//*[normalize-space()='" + field + "']/following-sibling::div//strong");
    }
    public static Target REGION_EFFECTIVE_VALUE(String field) {
        return Target.the("field " + field).locatedBy("(//*[normalize-space()='" + field + "']/following-sibling::div//strong)[2]");
    }
    public static Target EFFECTIVE_VALUE(String field) {
        return Target.the("field " + field).locatedBy("(//*[normalize-space()='" + field + "']/parent::label/following-sibling::div//strong)[2]");
    }

    public static Target CHANGE_REQUEST_FIELD(String field) {
        return Target.the("field " + field).locatedBy("//label[normalize-space()='" + field + "']/following-sibling::div/div/div");
    }

}

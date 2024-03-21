package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;

public class AdminProductRecommendationsPage {

    public static Target DYNAMIC_FIELD(String field) {
        return Target.the("field " + field).locatedBy("//div[@class='el-dialog__body']//label[contains(text(),'" + field + "')]/following-sibling::div//input");
    }

    public static Target EDIT_BUTTON(String field) {
        return Target.the("field " + field).locatedBy("//div[contains(text(),'" + field + "')]/ancestor::td/following-sibling::td//button[1]");
    }

    public static Target DELETE_BUTTON(String field) {
        return Target.the("field " + field).locatedBy("//div[contains(text(),'" + field + "')]/ancestor::td/following-sibling::td//button[2]");
    }

    public static Target DYNAMIC_REGION(String region) {
        return Target.the("field " + region).locatedBy("//span[contains(text(),'for region')]/following-sibling::span[@data-original-text='" + region + "']");
    }
}

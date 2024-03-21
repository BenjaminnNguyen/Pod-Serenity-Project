package cucumber.user_interface.admin.products;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminSKUDetailPage {

    public static Target DYNAMIC_FIELD(String region, String field) {
        return Target.the(field)
                .locatedBy("//div[contains(text(),'" + region + "')]/ancestor::div[contains(@class,'el-row')]/following-sibling::div//div[contains(@class,'" + field + "')]//input");
    }

    public static Target INVENTORY_COUNT(String region, String field) {
        return Target.the(field)
                .located(By.xpath("//div[contains(text(),'" + region + "')]/ancestor::div[contains(@class,'el-row')]/following-sibling::div//div[contains(@class,'" + field + "')]"));
    }

    public static Target STATE_REGION(String region) {
        return Target.the("")
                .located(By.xpath("//div[text()='" + region + "']/parent::div/following-sibling::div//div[contains(@class,'region-state')]"));
    }

}


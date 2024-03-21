package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class InventoryStatusPage {

    public static Target DYNAMIC_RESULT_IN_TABLE(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("(//td[contains(@class,'" + title + "')]//span)[1]"));
    }

    public static Target DYNAMIC_2_RESULT_IN_TABLE(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//td[contains(@class,'" + title + "')]//div"));
    }

    public static final Target STATUS_IN_TABLE = Target.the("Status in table result")
            .located(By.xpath("(//td[contains(@class,'status')]//div/div)[1]"));

    public static Target DYNAMIC_RESULT_IN_TABLE(String sku, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + sku + "')]/ancestor::tr/td[contains(@class,'" + title + "')]//span"));
    }
    public static Target DYNAMIC_RESULT_IN_TABLE2(String sku, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + sku + "')]/ancestor::tr/td[contains(@class,'" + title + "')]//div"));
    }
    public static Target REGION_IN_TABLE(String sku, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + sku + "')]/ancestor::tr/td[contains(@class,'" + title + "')]//ul[@class='regions']"));
    }

}

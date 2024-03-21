package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class InprocessOrderPage {

    /**
     * Result after search
     */

    public static Target ORDER_RESULT = Target.the("Order in result")
            .located(By.xpath("//td[contains(@class,'order-num')]//a"));

    public static Target CUSTOMER_PO_RESULT = Target.the("Customer po in result")
            .located(By.xpath("//td[contains(@class,'customer-po')]//span"));

    public static Target CREATOR_RESULT = Target.the("Creator in result")
            .located(By.xpath("//td[contains(@class,'creator')]//span"));

    public static Target STATUS_RESULT = Target.the("Status in result")
            .located(By.xpath("//td[contains(@class,'state')]//div[@class='status-tag']"));

    public static Target BUYER_RESULT = Target.the("Buyer in result")
            .located(By.xpath("//td[contains(@class,'buyer')]//span"));

    public static Target REGION_RESULT = Target.the("Region in result")
            .located(By.xpath("//td[contains(@class,'region')]//span"));

}

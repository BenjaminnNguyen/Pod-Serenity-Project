package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AboutToExpirePage {

    public static Target RED_NUMBER_EXPIRE_MENU = Target.the("Red number in Abount to expire menu")
            .located(By.xpath("(//li[@data-slug='inventories-about-to-expire']/span)[1]"));

    public static Target TOTAL_RECORD_IN_RESULT = Target.the("Total record in result")
            .located(By.xpath("//strong[@class='total']"));

}

package cucumber.user_interface.admin;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;


public class RequestsPageForm {

    public static Target PRODUCTNAME_TEXTBOX = Target.the("Product name textbox")
            .located(By.xpath("//div[@data-field='q[product_name]']//input"));

    public static Target SKUNAME_TEXTBOX = Target.the("SKU name textbox")
            .located(By.xpath("//div[@data-field='q[product_variant_name]']//input"));
}

package cucumber.user_interface.gmail;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class PaymentConfirmationPage {

    public static Target D_PRICE(String title) {
        return Target.the(title + "Price")
                .located(By.xpath("//td[text()='" + title + "']/following-sibling::td"));
    }

    public static final Target PRICE_TOTAL = Target.the("Payment confirmation header")
            .located(By.xpath("//td[text()='Total']/following-sibling::td/span"));


}

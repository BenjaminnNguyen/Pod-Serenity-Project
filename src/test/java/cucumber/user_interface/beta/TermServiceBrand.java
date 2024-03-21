package cucumber.user_interface.beta;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class TermServiceBrand {

    public static Target TERM_OF_SERVICE_LABEL = Target.the("Term of service label")
            .located(By.xpath("//div[text()='Terms of service']"));
}

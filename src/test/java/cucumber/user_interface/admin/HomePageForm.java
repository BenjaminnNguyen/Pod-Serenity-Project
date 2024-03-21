package cucumber.user_interface.admin;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class HomePageForm {
    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

}

package cucumber.user_interface.admin.setting;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class SettingAdminForm {

    public static Target ADMIN_HEADER = Target.the("Admin header")
            .located(By.xpath("//div[@class='title']//span"));
}

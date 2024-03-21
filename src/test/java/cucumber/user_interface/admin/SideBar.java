package cucumber.user_interface.admin;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class SideBar {
    public static Target PARENT_MENU(String title) {
        return Target.the("Parent Menu " + title)
                .locatedBy("//li[@role='menuitem']//span[text()='" + title + "']");
    }

    public static Target CHILD_MENU(String title) {
        return Target.the("Child Menu " + title)
                .locatedBy("//ul[@class='el-menu el-menu--inline']//span[text()='" + title + "']");
    }
}

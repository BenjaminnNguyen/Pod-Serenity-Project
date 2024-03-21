package cucumber.user_interface.admin.announcement;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AnnouncementPage {
    /**
     * Result table
     */
    public static Target D_RESULT(String value, int i) {
        return Target.the(value + " in result table")
                .located(By.xpath("(//td[contains(@class,'" + value + "')])[" + i + "]"));
    }
}

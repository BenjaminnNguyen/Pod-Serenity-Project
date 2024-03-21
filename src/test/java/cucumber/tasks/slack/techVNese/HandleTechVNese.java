package cucumber.tasks.slack.techVNese;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.slack.common.CommonSlackPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import org.openqa.selenium.Keys;

public class HandleTechVNese {

    public static Task search(String value) {
        return Task.where("",
                CommonWaitUntil.isVisible(CommonSlackPage.HEADER_SEARCH),
                Click.on(CommonSlackPage.HEADER_SEARCH),
                CommonWaitUntil.isVisible(CommonSlackPage.SEARCH_TEXTBOX_IN_POPUP),
                Enter.keyValues(value).into(CommonSlackPage.SEARCH_TEXTBOX_IN_POPUP).thenHit(Keys.ENTER)
                );
    }
}

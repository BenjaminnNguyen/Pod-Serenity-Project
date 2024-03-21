package cucumber.tasks.email;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.LoginGmailPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

public class HandleEmail {

    public static Performable search(String valueSearch) {
        return Task.where("Search value",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlDisplay(LoginGmailPage.SEARCH_BOX))
                                    .andIfSo(
                                            Clear.field(LoginGmailPage.SEARCH_BOX),
                                            Enter.theValue(valueSearch).into(LoginGmailPage.SEARCH_BOX).thenHit(Keys.ENTER)
                                    ),
                            WindowTask.threadSleep(3000)
                    );
                }

        );
    }

    public static Task goToDetailFirstEmail() {
        return Task.where("Go to detail of first email",
                CommonWaitUntil.isVisible(LoginGmailPage.FIRST_EMAIL),
                Click.on(LoginGmailPage.FIRST_EMAIL),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task goToInbox() {
        return Task.where("Go to inbox gmail",
                Click.on(LoginGmailPage.INBOX_BUTTON),
                WindowTask.threadSleep(1000)
//                CommonWaitUntil.isVisible(LoginGmailPage.REFESH_BUTTON)
        );
    }

    public static Task goToDetail(String title) {
        return Task.where("Go to email detail",
                CommonWaitUntil.isVisible(LoginGmailPage.EMAIL_WITH_TITLE1(title)),
                Click.on(LoginGmailPage.EMAIL_WITH_TITLE1(title)),
                WindowTask.threadSleep(2000)
        );
    }

}


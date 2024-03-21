package cucumber.tasks.login;

import cucumber.models.User;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.LoginGmailPage;
import cucumber.user_interface.beta.User_Header;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.waits.WaitUntil;
import net.thucydides.core.annotations.Step;
import org.openqa.selenium.Keys;

import static net.serenitybdd.screenplay.Tasks.instrumented;


public class LoginGmail implements Task {

    User user;
    String pass;

    @Step("{0} đăng nhập")
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(
                CommonWaitUntil.isVisible(LoginGmailPage.USERNAME_FIELD),
                Enter.theValue(user.getEmail())
                        .into(LoginGmailPage.USERNAME_FIELD),
                CommonWaitUntil.isVisible(LoginGmailPage.BUTTON_NEXT),
                Click.on(LoginGmailPage.BUTTON_NEXT),
                CommonWaitUntil.isVisible(LoginGmailPage.PASSWORD_FIELD),
                Enter.theValue(user.getPassword())
                        .into(LoginGmailPage.PASSWORD_FIELD).thenHit(Keys.ENTER)
//                Click.on(LoginGmailPage.BUTTON_NEXT),
//                CommonWaitUntil.isVisible(LoginGmailPage.GMAIL_TITLE)
                );
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * Hàm thực hiện task đăng nhập vào hệ thống
     *
     * @param user Thông tin đăng nhập
     * @param pass
     */
    public static LoginGmail as(User user, String pass) {
        return instrumented(LoginGmail.class, user, pass);
    }

    public LoginGmail(User user, String pass) {
        this.user = user;
        this.pass = pass;
    }

}

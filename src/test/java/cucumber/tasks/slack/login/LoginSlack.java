package cucumber.tasks.slack.login;

import cucumber.models.User;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.slack.login.LoginSlackPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

public class LoginSlack {

    public static Task as(User user) {
        return Task.where("Login slack",
                CommonWaitUntil.isVisible(LoginSlackPage.EMAIL_TEXTBOX),
                Enter.theValue(user.getEmail())
                        .into(LoginSlackPage.EMAIL_TEXTBOX),
                Enter.theValue(user.getPassword())
                        .into(LoginSlackPage.PASSWORD_TEXTBOX),
                Click.on(LoginSlackPage.SIGN_IN_BUTTON),
                CommonWaitUntil.isVisible(LoginSlackPage.USE_SLACK_WEB)
        );
    }

    public static Task useWeb() {
        return Task.where("Use slack in your browser",
                CommonWaitUntil.isVisible(LoginSlackPage.USE_SLACK_WEB),
                Click.on(LoginSlackPage.USE_SLACK_WEB),
                CommonWaitUntil.isVisible(LoginSlackPage.AVATAR_BUTTON)
        );
    }

    public static Task changeLanguage() {
        return Task.where("Change language slack",
                CommonWaitUntil.isVisible(LoginSlackPage.CHANGE_LANGUAGE),
                Click.on(LoginSlackPage.CHANGE_LANGUAGE),
                CommonWaitUntil.isVisible(LoginSlackPage.ENGLISH_LANGUAGE),
                Click.on(LoginSlackPage.ENGLISH_LANGUAGE)
        );
    }
}

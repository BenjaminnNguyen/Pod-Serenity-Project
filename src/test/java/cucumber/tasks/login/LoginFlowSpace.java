package cucumber.tasks.login;

import cucumber.models.User;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.flowspace.FSLoginPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

public class LoginFlowSpace {

    public static Task flowspace(User user) {
        return Task.where("Login",
                CommonWaitUntil.isVisible(FSLoginPage.EMAIL_FIELD),
                Enter.theValue(user.getEmail())
                        .into(FSLoginPage.EMAIL_FIELD),
                Enter.theValue(user.getPassword())
                        .into(FSLoginPage.PASSWORD_FIELD),
                Click.on(FSLoginPage.SIGN_IN_BUTTON)
        );
    }

}

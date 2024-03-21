package cucumber.tasks.login;

import cucumber.models.User;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin_old.login.LoginAdminOldPage;
import cucumber.user_interface.beta.LoginForm;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;

public class LoginAdminOld {

    public static Task as(User user) {
        return Task.where("Login in admin old",
                CommonWaitUntil.isPresent(LoginAdminOldPage.LOGIN_BUTTON),
                Enter.keyValues(user.getEmail())
                        .into(LoginAdminOldPage.USERNAME_FIELD),
                Enter.keyValues(user.getPassword())
                        .into(LoginAdminOldPage.PASSWORD_FIELD),
                Click.on(LoginAdminOldPage.LOGIN_BUTTON)
                );
    }
}

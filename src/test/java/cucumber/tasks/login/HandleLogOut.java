package cucumber.tasks.login;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.User_Header;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ui.Link;

public class HandleLogOut {

    public static Task as() {
        return Task.where("Log out",
                CommonWaitUntil.isPresent(User_Header.LOG_OUT_BUTTON),
                Click.on(User_Header.LOG_OUT_BUTTON),
                CommonWaitUntil.isVisible(User_Header.LOG_OUT_POPUP_BUTTON),
                Click.on(User_Header.LOG_OUT_POPUP_BUTTON),
                CommonWaitUntil.isVisible(LoginForm.LOGIN_BUTTON)
        );
    }
}

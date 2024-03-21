package cucumber.tasks.login;

import cucumber.models.User;
import cucumber.singleton.GVs;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.User_Header;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.ui.Button;
import net.serenitybdd.screenplay.ui.InputField;
import net.serenitybdd.screenplay.ui.Link;
import net.serenitybdd.screenplay.ui.PageElement;
import net.serenitybdd.screenplay.waits.WaitUntil;
import net.thucydides.core.annotations.Step;
import net.thucydides.core.util.EnvironmentVariables;

import static net.serenitybdd.screenplay.Tasks.instrumented;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;


public class LoginUser implements Task {

    User user;
    String role;

    @Step("{0} đăng nhập")
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.SIGN_IN_BUTTON),
                Enter.theValue(user.getEmail())
                        .into(InputField.withNameOrId("email")),
                Enter.theValue(user.getPassword())
                        .into(InputField.withNameOrId("password")),
                Check.whether(role.toUpperCase().contains("BUYER"))
                        .andIfSo(
                                Click.on(PageElement.containingText("Buyer")))
                        .otherwise(
                                Check.whether(role.equalsIgnoreCase("Vendor"))
                                        .andIfSo(Click.on(PageElement.containingText("Vendor")))
                        ),
                Click.on(HomePageForm.SIGN_IN_BUTTON).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(5000)
        );
        if (role.equalsIgnoreCase("LP")) {
            actor.attemptsTo(
                    Check.whether(valueOf(HomePageForm.PRIVACY_POLICY_POPUP), isCurrentlyVisible())
                            .andIfSo(
                                    Check.whether(valueOf(HomePageForm.PRIVACY_POLICY_READ), isCurrentlyVisible())
                                            .andIfSo(
                                                    Click.on(HomePageForm.PRIVACY_POLICY_READ).afterWaitingUntilEnabled()),
                                    Check.whether(valueOf(HomePageForm.TERM_OF_USE_READ), isCurrentlyVisible())
                                            .andIfSo(
                                                    Click.on(HomePageForm.TERM_OF_USE_READ).afterWaitingUntilEnabled()),
                                    Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("I accept")).afterWaitingUntilEnabled(),
                                    CommonWaitUntil.isNotVisible(HomePageForm.PRIVACY_POLICY_POPUP)
                            )
            );
        } else {
            actor.attemptsTo(
                    Check.whether(valueOf(HomePageForm.TERM_OF_USE), isCurrentlyVisible())
                            .andIfSo(
                                    // privacy policy
                                    Check.whether(valueOf(HomePageForm.PRIVACY_POLICY_READ), isCurrentlyVisible())
                                            .andIfSo(Click.on(HomePageForm.PRIVACY_POLICY_READ)),
                                    // tick term of use
                                    Click.on(HomePageForm.TERM_OF_USE),
                                    CommonWaitUntil.isVisible(HomePageForm.TERM_OF_USE_READ),
                                    Click.on(HomePageForm.TERM_OF_USE_READ),
                                    Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("I accept")).afterWaitingUntilEnabled(),
                                    CommonWaitUntil.isNotVisible(HomePageForm.TERM_OF_USE)
                            ),
                    Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                            .andIfSo(
                                    Click.on(HomePageForm.I_ACCEPT),
                                    Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                                            .andIfSo(
                                                    Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                                    Click.on(HomePageForm.CLOSE_POPUP),
                                                    CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                                            ),
                                    CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                            ),
                    Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                            .andIfSo(
                                    Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                    Click.on(HomePageForm.CLOSE_POPUP),
                                    Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                                            .andIfSo(
                                                    Click.on(HomePageForm.I_ACCEPT),
                                                    CommonWaitUntil.isNotVisible(HomePageForm.I_ACCEPT),
                                                    CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                                            )
                            ),
                    Check.whether(valueOf(HomePageForm.BUTTON_CLOSE_POPUP_CONVERT), isCurrentlyVisible())
                            .andIfSo(
                                    JavaScriptClick.on(HomePageForm.BUTTON_CLOSE_POPUP_CONVERT),
                                    CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                            )
            );
            if(role.equalsIgnoreCase("VENDOR")){
                actor.attemptsTo(
                        Click.on(HomePageForm.DASHBOARD_BUTTON).afterWaitingUntilPresent()
                );
            }
        }
    }

    /**
     * Hàm thực hiện task đăng nhập vào hệ thống
     *
     * @param user Thông tin đăng nhập
     * @param role Vai trò
     */
    public static LoginUser as(User user, String role) {
        return instrumented(LoginUser.class, user, role);
    }

    public LoginUser(User user, String role) {
        this.user = user;
        this.role = role;
    }

}

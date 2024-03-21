package cucumber.tasks.login;

import cucumber.actions.DeleteAllCookies;
import cucumber.pages.LoginAdminPage;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Open;
import net.thucydides.core.annotations.Step;

import static net.serenitybdd.screenplay.Tasks.instrumented;

public class Start implements Task {

    @Step("{0} mở trang Đăng nhập")
    public <T extends Actor> void performAs(T actor) {
        actor.attemptsTo(
                DeleteAllCookies.theBrowserSession()
        );
    }

    public static Start start() {
        return instrumented(Start.class);
    }

    public Start() {
    }
}

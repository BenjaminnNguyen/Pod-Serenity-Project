package steps.slack.login;

import cucumber.models.User;
import cucumber.singleton.GVs;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.login.LoginAdmin;
import cucumber.tasks.login.LoginUser;
import cucumber.tasks.login.Start;
import cucumber.tasks.slack.login.LoginSlack;
import io.cucumber.java.Before;
import io.cucumber.java.en.Given;
import net.serenitybdd.screenplay.actions.Open;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.serenitybdd.screenplay.conditions.Check;

import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;


public class LoginSlackStepDefinitions {

    @Before()
    public void set_the_stage() {
        OnStage.setTheStage(new OnlineCast());
    }


    @Given("{word} login to slack")
    public void login_to_slack(String name) {
        User user = CommonTask.getUser(name);
        theActorInTheSpotlight().attemptsTo(
                LoginSlack.changeLanguage(),
                LoginSlack.as(user),
                LoginSlack.useWeb()
        );
    }

    @Given("Login to slack with email {string} pass {string}")
    public void login_to_slack(String email, String pass) {
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                LoginSlack.changeLanguage(),
                LoginSlack.as(user),
                LoginSlack.useWeb()
        );
    }
}

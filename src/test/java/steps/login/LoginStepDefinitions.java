package steps.login;

import cucumber.actions.*;
import cucumber.constants.buyer.WebsiteBuyerConstants;

import cucumber.tasks.vendor.VendorDashboardTask;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import cucumber.user_interface.flowspace.FSHomePage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import cucumber.models.User;
import cucumber.singleton.GVs;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.NavigateToSideBar;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.login.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.SideBar;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.LoginGmailPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Open;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.ui.Link;
import net.thucydides.core.util.EnvironmentVariables;

import java.util.List;
import java.util.Map;

import static cucumber.singleton.GVs.*;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.the;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class LoginStepDefinitions {

    public static EnvironmentVariables env;

    @Before()
    public void set_the_stage() {
        OnStage.setTheStage(new OnlineCast());
        String enviroment = null;
        if (System.getProperty("environments") == null) {
            enviroment = "default";
        } else {
            enviroment = System.getProperty("environments");
        }
        GVs.ENVIRONMENT = enviroment;
    }

    /* LOGIN STEP DEFINITIONS */
    @Given("{word} open web admin")
    public void open_web(String actor) {
        theActorCalled(actor).wasAbleTo(
                Start.start(),
                Open.url(URL_ADMIN + "login"));
    }

    @Given("{word} open web user")
    public void open_web_user(String actor) {
        theActorCalled(actor).wasAbleTo(
                Start.start(),
                Open.url(URL_BETA + "login")
        );
    }

    @Given("{word} maximize browser")
    public void maximize_browser(String actor) {
        BrowseTheWeb.as(theActorInTheSpotlight()).getDriver().manage().window().maximize();
    }

    @Given("{word} open web LP")
    public void open_web_LP(String actor) {
        theActorCalled(actor).wasAbleTo(
                Start.start(),
                Open.url(URL_LP + "login/")
        );
    }

    @Given("{word} go to admin beta")
    public void go_to_admin_beta(String actor) {
        theActorCalled(actor).wasAbleTo(Open.url(URL_ADMIN));
    }

    @Given("{word} open login gmail with email {string} pass {string}")
    public void open_login_gmail(String actor, String email, String pass) {
        User user = CommonTask.setUser(email, pass);
        theActorCalled(actor).attemptsTo(
                Open.url("https://stackoverflow.com/users/login"),
                CommonWaitUntil.isVisible(LoginGmailPage.GG_STACKOVER),
                Click.on(LoginGmailPage.GG_STACKOVER),
                LoginGmail.as(user, pass),
                Open.url("https://mail.google.com/mail")
        );
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    @Given("{word} open login gmail")
    public void open_gmail(String actor) {
        theActorCalled(actor).attemptsTo(
                Start.start(),
                Open.url("https://mail.google.com/mail")
        );
    }

    @Given("login to beta web with email {string} pass {string} role {string}")
    public void login_to_web(String email, String pass, String role) {
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(role.equals("Admin"))
                        .andIfSo(
                                LoginAdmin.as(user))
                        .otherwise(
                                LoginUser.as(user, role),
                                WindowTask.threadSleep(1000))
        );
        Serenity.setSessionVariable("Role buyer").to(role);
    }

    @Given("login to onboard web")
    public void login_onboard() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("12345678a").into(LoginForm.PASSWORD_FIELD),
                Click.on(LoginForm.LOGIN_BUTTON),
                WindowTask.threadSleep(1000)
        );
    }

    @Given("login to onboard web with email {string} pass {string} role {string}")
    public void login_onboard_success(String email, String pass, String role) {
        if (email.equals("random")) {
            email = Serenity.sessionVariableCalled("Email Onboard");
        }
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                LoginUser.as(user, role),
                WindowTask.threadSleep(1000)
        );
    }

    @Given("{word} login to web with role {word}")
    public void login_to_web(String name, String role) {
        User user = CommonTask.getUser(name);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(role.equals("Admin"))
                        .andIfSo(
                                LoginAdmin.as(user))
                        .otherwise(
                                LoginUser.as(user, role))
        );
    }

    @And("{word} navigate to {string} to {string} by sidebar")
    public void navigateTo(String actor, String parentName, String childName) {
        theActorCalled(actor).attemptsTo(
                NavigateToSideBar.navigate(childName, SideBar.PARENT_MENU(parentName), SideBar.CHILD_MENU(childName))
        );
    }

    @And("Admin navigate to {string} on sidebar")
    public void navigateTo(String tab) {
        theActorInTheSpotlight().attemptsTo(
                NavigateToSideBar.navigate(SideBar.PARENT_MENU(tab))
        );
    }

    @And("{word} open url {string}")
    public void openURL(String actor, String url) {
        theActorCalled(actor).attemptsTo(
                Open.url(GVs.URL_ADMIN + url)
        );
    }

    @And("{word} open withdraw request")
    public void openWithdrawRequest(String actor) {
        theActorCalled(actor).attemptsTo(
                Open.url(URL_BETA + "vendors/inventory/withdrawal-requests")
        );
    }

    @Given("{word} open web admin old")
    public void open_web_admin_old(String actor) {
        theActorCalled(actor).wasAbleTo(
                Start.start(),
                Open.url(URL_APIBETA),
                WindowTask.threadSleep(5000)
        );
    }

    @Given("login to admin old web with email {string} pass {string}")
    public void login_to_web_admin_old(String email, String pass) {
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                LoginAdminOld.as(user)
        );
    }

    @Given("Switch to actor {word}")
    public void switchActor(String actor) {
        theActorCalled(actor).assignName(theActorInTheSpotlight().getName());

    }

    @Given("{word} log out")
    public void log_out(String role) {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardTask.navigate("Settings", VendorDashboardPage.OPTION("Settings")),
                HandleLogOut.as()
        );
    }

    @Given("{word} log out and close")
    public void log_out_and_close(String role) {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardTask.navigate("Settings", VendorDashboardPage.OPTION("Settings")),
                HandleLogOut.as(),
                Close.theBrowserSession()
        );
    }

    @And("{word} refresh page admin")
    public void refreshPage_admin(String actor) {
        theActorCalled(actor).attemptsTo(
                Refesh.theBrowserSession(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("{word} refresh page")
    public void refreshPage(String actor) {
        theActorCalled(actor).attemptsTo(
                Refesh.theBrowserSession(),
                WindowTask.threadSleep(1000),
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        )
        );
    }

    @Given("{word} close web")
    public void close_web(String actor) {
        theActorCalled(actor).wasAbleTo(
                Close.theBrowserSession()
        );
    }

    @Given("{word} open web guest claim")
    public void open_web_guest_claim(String actor) {
        theActorCalled(actor).wasAbleTo(
                Open.url(URL_BETA + "claim")
        );
    }

    @Given("{word} delete all cookies and session")
    public void user_delete_all_cookies_and_session(String actor) {
        theActorCalled(actor).wasAbleTo(
                DeleteAllCookies.theBrowserSession()
        );
    }

    @And("{word} verify login button")
    public void verify_login_button(String actor) {
        theActorCalled(actor).attemptsTo(
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                CommonWaitUntil.isVisible(HomePageForm.SIGNIN_BUTTON_AFTER_DELETE_COOKIE),
                Ensure.that(HomePageForm.SIGNIN_BUTTON_AFTER_DELETE_COOKIE).isDisplayed()
        );
    }

    @And("Buyer login with email {string} and password {string}")
    public void buyer_login(String email, String pass) {
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LoginForm.LOGIN_BUTTON),
                Enter.theValue(user.getEmail())
                        .into(LoginForm.USERNAME_FIELD),
                Enter.theValue(user.getPassword())
                        .into(LoginForm.PASSWORD_FIELD),
                Click.on(LoginForm.TYPE_CUSTOMER_RADIO("buyer")),
                Click.on(LoginForm.LOGIN_BUTTON)
        );
    }

    @And("{word} check Privacy Policy and accept")
    public void checkPrivacy(String actor) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT(WebsiteBuyerConstants.PRIVACY_POLICY)),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT("Keeping your Data Safe")),
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_ANY_TEXT("Privacy Policy")),
                CommonWaitUntil.isVisible(HomePageForm.I_ACCEPT),
                Click.on(HomePageForm.I_ACCEPT),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
        );
    }

    @And("{word} accept Privacy Policy")
    public void acceptPrivacy(String actor) {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                CommonWaitUntil.isVisible(HomePageForm.I_ACCEPT),
                                Click.on(HomePageForm.I_ACCEPT)
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
        );
    }

    @And("Admin go back by browser")
    public void admin_go_back_by_browser() {
        theActorInTheSpotlight().attemptsTo(
                GoBack.theBrowser()
        );
    }

    @And("{word} quit browser")
    public void quit_browser(String actor) {
        theActorCalled(actor).attemptsTo(
                WindowTask.quit()
        );
    }

    @When("{word} reset password")
    public void reset_password(String actor, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorCalled(actor).attemptsTo(
                LoginAdmin.resetPassword(infos.get(0))
        );
    }

    /**
     * Login flowspace
     */

    @Given("{word} open web flowspace")
    public void open_web_flowspace(String actor) {
        theActorCalled(actor).wasAbleTo(
                Start.start(),
                Open.url(GVs.URL_FLOWSPACE));
    }

    @Given("Login to flowspace with email {string} pass {string}")
    public void login_to_flowspace(String email, String pass) {
        User user = CommonTask.setUser(email, pass);
        theActorInTheSpotlight().attemptsTo(
                LoginFlowSpace.flowspace(user)
        );
    }

    @And("{word} navigate to {string} of flowspace by sidebar")
    public void flowspace_navigateTo(String actor, String title) {
        theActorCalled(actor).attemptsTo(
                NavigateToSideBar.navigateFlowSpace(FSHomePage.SIDEBAR_MENU(title))
        );
    }
}

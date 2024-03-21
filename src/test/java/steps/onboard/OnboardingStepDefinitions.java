package steps.onboard;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.onboard.HandleOnboard;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.Onboarding.RegisterPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class OnboardingStepDefinitions {

    @And("User register onboard")
    public void open_web_user(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(RegisterPage.REGISTER_BUTTON),
                HandleOnboard.fillInfo(infos.get(0))
        );
    }

    @And("User choose contact type and fill info")
    public void choose_contact_type_and_fill_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.fillInfoOfRole(infos.get(0))
        );
    }

    @And("User choose region store located in")
    public void choose_region_store_located_in(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOnboard.chooseRegion(info.get("region"))
            );
        }
    }

    @And("User choose category")
    public void choose_category(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOnboard.chooseCategory(info.get("category"))
            );
        }
    }

    @And("User go to {word}")
    public void next_page(String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(RegisterPage.DYNAMIC_BUTTON(name))
        );
    }

    @And("User fill info about company")
    public void fill_info_about_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String name = "AutoOnboard" + CommonTask.getDateTimeString();
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        if (info.get("nameCompany").equals("random")) {
            info.replace("nameCompany", "random", name);
        }
        if (info.get("nameCompanyDBA").equals("random")) {
            info.replace("nameCompanyDBA", "random", name);
        }
        System.out.println("Onboard Name Company " + info.get("nameCompany"));
        Serenity.setSessionVariable("Onboard Name Company").to(info.get("nameCompany"));
        Serenity.setSessionVariable("Onboard Name Company DBA").to(info.get("nameCompanyDBA"));

        //in report
//        Serenity.recordReportData().asEvidence().withTitle("Onboard Name Company").andContents(info.get("nameCompany"));
//        Serenity.recordReportData().asEvidence().withTitle("Onboard Name Company DBA").andContents(info.get("nameCompanyDBA"));

        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.fillAbountCompany(info)
        );
    }

    @And("User fill info your company address")
    public void fill_info_your_company_address(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.fillCompanyAddress(infos.get(0))
        );
    }

    @And("User fill info your account")
    public void fill_info_your_account(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String email = "autoonboard" + CommonTask.getDateTimeString() + "@podfoods.co";
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "email", email);
        Serenity.setSessionVariable("Email Onboard").to(email);
//        Serenity.recordReportData().asEvidence().withTitle("Email Onboard").andContents(email);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.fillAccount(info)
        );
    }

    @And("User verify about your company")
    public void user_verify_about_your_company(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company name")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company name")).attribute("value").contains(expected.get(0).get("nameCompany")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Contact email")).attribute("value").contains(expected.get(0).get("email"))
        );
    }

    @And("User verify about your account")
    public void user_verify_about_your_account(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("First name")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("First name")).attribute("value").contains(expected.get(0).get("firstName")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Last name")).attribute("value").contains(expected.get(0).get("lastName")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Contact phone number")).attribute("value").contains(expected.get(0).get("phone"))
        );
    }

    @And("User get started")
    public void get_started() {
        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.getStartedThenLogin()
        );
    }

    @And("User fill info in Retailer Details")
    public void fill_info_in_retailer_details() {
        theActorInTheSpotlight().attemptsTo(
                HandleOnboard.getStartedThenLogin()
        );
    }

    @And("User verify onboard login screen")
    public void verify_onboard_login_screen(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String email = expected.get(0).get("email");
        if (expected.get(0).get("email").equals("random")) {
            email = Serenity.sessionVariableCalled("Email Onboard");
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.attributeText(LoginForm.USERNAME_FIELD, "value"), containsString(email)),
                seeThat(CommonQuestions.attributeText(LoginForm.LABEL_ROLE(expected.get(0).get("role")), "class"), containsString("is-active"))
        );
    }

}

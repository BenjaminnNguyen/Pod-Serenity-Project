package steps.vendor.login;

import com.fasterxml.jackson.databind.JsonNode;
import io.cucumber.java.Before;
import io.cucumber.java.en.*;
import cucumber.models.User;
import cucumber.singleton.GVs;
import cucumber.singleton.UrlAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.LoginAdminAPI;
import cucumber.tasks.api.vendor.ProductAPI;
import cucumber.tasks.common.CommonTask;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.environment.EnvironmentSpecificConfiguration;
import net.serenitybdd.screenplay.actors.OnStage;
import net.serenitybdd.screenplay.actors.OnlineCast;
import net.thucydides.core.util.EnvironmentVariables;
import org.json.JSONObject;

public class LoginAPIStepDefinitions {

    public static EnvironmentVariables env;
    LoginAdminAPI loginAdminAPI = new LoginAdminAPI();
    CommonHandle commonHandle = new CommonHandle();

    @Before
    public void set_the_stage() {
        OnStage.setTheStage(new OnlineCast());
    }

    /**
     * APIIIIIIIIIIIIIIIIIIIIIII
     */
    @Given("{word} login web with role {string} by api")
    public void login_to_app_by_API(String name, String role, User user) {
        String basePath = UrlAPI.SIGNIN_VENDOR;
        Response response = loginAdminAPI.callSignIn(user, basePath);
        // lấy uid cho api
        Serenity.setSessionVariable("uid").to(user.getEmail());
        // lấy access-token và clienID từ response Signin
        commonHandle.getInfoFromHeaderSign(response);
    }

    /**
     * LOGIN api with BUYER
     */
    @Given("Buyer login web with by api")
    public void buyer_login_by_API(User user) {
        String basePath = UrlAPI.BUYER_LOGIN;
        Response response = loginAdminAPI.callSignIn(user, basePath);
        // lấy uid cho api
        Serenity.setSessionVariable("uid").to(user.getEmail());
        // lấy access-token và clienID từ response Signin
        commonHandle.getInfoFromHeaderSign(response);
    }
}

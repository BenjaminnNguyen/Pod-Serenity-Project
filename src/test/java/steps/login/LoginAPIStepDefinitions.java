package steps.login;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.*;
import io.cucumber.java.en.*;
import cucumber.models.User;
import cucumber.singleton.GVs;
import cucumber.singleton.UrlAdminAPI;
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

import java.lang.reflect.Type;
import java.util.Map;

public class LoginAPIStepDefinitions {

    public static EnvironmentVariables env;
    LoginAdminAPI loginAdminAPI = new LoginAdminAPI();
    CommonHandle commonHandle = new CommonHandle();

    ProductAPI productAPI = new ProductAPI();

    @Before
    public void set_the_stage() {
        OnStage.setTheStage(new OnlineCast());
    }

    @DataTableType(replaceWithEmptyString = "[blank]")
    public String listOfStringListsType(String cell) {
        return cell;
    }

    @Given("{word} login to web with role {string} with API")
    public void signInAPI(String name, String role) {
        User user = CommonTask.getUser(name);
        if (role.equals("buyer")) {
            GVs.ENVIRONMENT_BASEURI = EnvironmentSpecificConfiguration.from(env).getProperty("environments.default.apiBuyer");
        } else {
            GVs.ENVIRONMENT_BASEURI = EnvironmentSpecificConfiguration.from(env).getProperty("environments.default.apiVendor");
        }
        String basePath = UrlAdminAPI.SIGNIN;
        System.out.println("basePath " + GVs.ENVIRONMENT_BASEURI + UrlAdminAPI.SIGNIN);

        Response response = loginAdminAPI.callSignIn(user, basePath);
        commonHandle.handleSignInResponse(response);

    }

    /**
     * APIIIIIIIIIIIIIIIIIIIIIII
     */
    @Given("{word} login web admin by api")
    public void login_to_app_by_API(String name, User user) {
        String basePath = UrlAdminAPI.SIGNIN;
        Response response = loginAdminAPI.callSignIn(user, basePath);
        // lấy uid cho api
        Serenity.setSessionVariable("uid").to(user.getEmail());
        // lấy access-token và clienID từ response Signin
        commonHandle.getInfoFromHeaderSign(response);
    }

}

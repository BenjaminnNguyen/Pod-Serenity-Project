package cucumber.tasks.api;

//import cucumber.config.ReportPortal;
import cucumber.models.User;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

public class LoginAdminAPI {

    public Response callSignIn(User user, String basePath) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestLogin(user, basePath);
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SIGN IN:  ").andContents(response.prettyPrint());
        return response;
    }
}

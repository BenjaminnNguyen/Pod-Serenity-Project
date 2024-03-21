package cucumber.user_interface.flowspace;

import net.serenitybdd.screenplay.targets.Target;

public class FSLoginPage {

    public static final Target EMAIL_FIELD = Target.the("Email")
            .locatedBy("//input[@id='user_email']");

    public static final Target PASSWORD_FIELD = Target.the("Password")
            .locatedBy("//input[@id='user_password']");

    public static final Target SIGN_IN_BUTTON = Target.the("Sign in button")
            .locatedBy("//input[@value='Sign In']");


}

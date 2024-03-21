package cucumber.user_interface.slack.login;

import net.serenitybdd.screenplay.targets.Target;

public class LoginSlackPage {

    public static final Target EMAIL_TEXTBOX = Target.the("Email textbox")
            .locatedBy("//input[contains(@name,'email')]");

    public static final Target PASSWORD_TEXTBOX = Target.the("Password textbox")
            .locatedBy("//input[contains(@type,'password')]");

    public static Target SIGN_IN_BUTTON = Target.the("Button sign in")
            .locatedBy("//button[contains(text(),'Sign in')]");

    public static Target USE_SLACK_WEB = Target.the("Use Slack in your browser")
            .locatedBy("//a[text()='use Slack in your browser']");

    public static Target AVATAR_BUTTON = Target.the("Avatar button")
            .locatedBy("(//button//span[contains(@class,'c-avatar')])[1]");

    public static Target CHANGE_LANGUAGE = Target.the("Change language")
            .locatedBy("//a[text()='Changer de région']");

    public static Target ENGLISH_LANGUAGE = Target.the("Change language")
            .locatedBy("//a[text()='United States (English)']");

}

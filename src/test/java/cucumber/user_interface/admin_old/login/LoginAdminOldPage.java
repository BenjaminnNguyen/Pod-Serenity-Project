package cucumber.user_interface.admin_old.login;

import net.serenitybdd.screenplay.targets.Target;

public class LoginAdminOldPage {

    // Page admin
    public static final Target USERNAME_FIELD = Target.the("'Tên đăng nhập'")
            .locatedBy("//input[contains(@id,'admin_email')]");

    public static final Target PASSWORD_FIELD = Target.the("'Mật khẩu'")
            .locatedBy("//input[contains(@type,'password')]");

    public static Target LOGIN_BUTTON = Target.the("'Button Log in'")
            .locatedBy("//button[contains(text(),'Sign in')]");

}

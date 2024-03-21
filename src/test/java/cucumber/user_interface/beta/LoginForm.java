package cucumber.user_interface.beta;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class LoginForm {

    public static final Target USERNAME_FIELD = Target.the("'Tên đăng nhập'").located(By.name("email"));

    public static final Target PASSWORD_FIELD = Target.the("'Mật khẩu'").located(By.name("password"));

    public static Target LOGIN_BUTTON = Target.the("'Button Log in'")
            .locatedBy("//span[normalize-space()='Login']");

    public static Target SIGNIN_BUTTON = Target.the("'Button Sign in'")
            .locatedBy("//div[@class='login']");

    public static Target TYPE_CUSTOMER_RADIO(String type) {
        return Target.the("Radio I am " + type)
                .locatedBy("//input[@value='" + type + "']/following-sibling::span");
    }

    // Page admin
    public static final Target ADMIN_USERNAME_FIELD = Target.the("'Tên đăng nhập'")
            .locatedBy("//input[contains(@type,'text')]");

    public static final Target ADMIN_PASSWORD_FIELD = Target.the("'Mật khẩu'")
            .locatedBy("//input[contains(@type,'password')]");

    public static Target ADMIN_LOGIN_BUTTON = Target.the("'Button Log in'")
            .locatedBy("//button/span[contains(text(),'Login')]");

    public static Target LABEL_ROLE(String type) {
        return Target.the("Radio I am " + type)
                .locatedBy("//input[@value='" + type + "']/parent::label");
    }

    /**
     * Reset password
     */
    public static Target RESET_BUTTON = Target.the("Reset link")
            .locatedBy("//a[@title='Reset your password']");

    public static Target EMAIL_TEXTBOX_IN_RESET = Target.the("Email textbox in reset password")
            .locatedBy("//label[text()='Email']/following-sibling::div//input");

    public static Target TYPE_VENDOR_IN_RESET = Target.the("Vendor button in reset password")
            .locatedBy("//span[text()=\"I'm a Vendor\"]");

    public static Target TYPE_BUYER_IN_RESET = Target.the("Buyer button in reset password")
            .locatedBy("//span[text()=\"I'm a Buyer\"]");

    public static Target SEND_INSTRUCTION_BUTTON = Target.the("Send intructions button")
            .locatedBy("//button/span[text()='Send intructions']");

}

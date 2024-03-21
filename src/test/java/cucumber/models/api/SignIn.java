package cucumber.models.api;

import lombok.Data;

@Data
public class SignIn {
    /**
     * Model signIn đăng nhập vào hệ thống
     */
    String email;
    String password;

}

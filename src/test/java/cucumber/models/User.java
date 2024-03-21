package cucumber.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	/**
	 * Tên đăng nhập
	 */
	String email;
	/**
	 * Mật khẩu
	 */
	String password;

}

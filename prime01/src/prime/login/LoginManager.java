package prime.login;

import java.sql.SQLException;
import prime.admin.user.UserBean;

public interface LoginManager {
	public UserBean getUser(String username) throws SQLException;
}

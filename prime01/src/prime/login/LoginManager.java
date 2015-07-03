package prime.login;

import java.sql.SQLException;

public interface LoginManager {
	
	public boolean isUserExists(String username) throws SQLException;

	public boolean isUserValidated(String username, String password) throws SQLException;

	public LoginBean getUserDetails(String username) throws SQLException;

	public void setLoginSession(String username) throws SQLException;

	public String getLoginSession(String username) throws SQLException;
}

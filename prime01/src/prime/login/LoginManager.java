package prime.login;


public interface LoginManager {
	public boolean isUserExists(String username);
	public boolean isUserValidated(String username, String password);
	public LoginBean getUserDetails(String username);
}

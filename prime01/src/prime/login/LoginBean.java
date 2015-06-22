package prime.login;

public class LoginBean {
	private String  username;
	private boolean isActiveDirectory;
	private Integer statusUser;
	private String  loginSession;
	private Integer employeeId;
	private Integer systemLevel;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public boolean isActiveDirectory() {
		return isActiveDirectory;
	}
	public void setActiveDirectory(boolean isActiveDirectory) {
		this.isActiveDirectory = isActiveDirectory;
	}
	public String getLoginSession() {
		return loginSession;
	}
	public void setLoginSession(String loginSession) {
		this.loginSession = loginSession;
	}
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public Integer getSystemLevel() {
		return systemLevel;
	}
	public void setSystemLevel(Integer systemLevel) {
		this.systemLevel = systemLevel;
	}
	public Integer getStatusUser() {
		return statusUser;
	}
	public void setStatusUser(Integer statusUser) {
		this.statusUser = statusUser;
	}
}

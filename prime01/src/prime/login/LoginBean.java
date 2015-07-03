package prime.login;

import java.util.Date;

public class LoginBean {
	private String  username;
	private Integer activeDirectory;
	private Integer statusUser;
	private String  loginSession;
	private Integer employeeId;
	private Integer systemLevel;
	private Date 	actionDate;
	private byte[] 	profilePicture;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	public Date getActionDate() {
		return actionDate;
	}
	public void setActionDate(Date actionDate) {
		this.actionDate = actionDate;
	}
	public byte[] getProfilePicture() {
		return profilePicture;
	}
	public void setProfilePicture(byte[] profilePicture) {
		this.profilePicture = profilePicture;
	}
	public Integer getActiveDirectory() {
		return activeDirectory;
	}
	public void setActiveDirectory(Integer activeDirectory) {
		this.activeDirectory = activeDirectory;
	}
}

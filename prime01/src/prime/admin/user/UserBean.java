package prime.admin.user;

import prime.admin.employee.EmployeeBean;

public class UserBean extends EmployeeBean{
	private Boolean isActiveDirectory;
	private Integer sysLevel;
	private String password;
	private String userName;
	private String statusUser;
	
	public Boolean getIsActiveDirectory() {
		return isActiveDirectory;
	}
	public void setIsActiveDirectory(Boolean isActiveDirectory) {
		this.isActiveDirectory = isActiveDirectory;
	}
	public Integer getSysLevel() {
		return sysLevel;
	}
	public void setSysLevel(Integer sysLevel) {
		this.sysLevel = sysLevel;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getStatusUser() {
		return statusUser;
	}
	public void setStatusUser(String statusUser) {
		this.statusUser = statusUser;
	}
	
}

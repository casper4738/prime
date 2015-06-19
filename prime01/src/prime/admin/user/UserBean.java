package prime.admin.user;

import prime.admin.employee.EmployeeBean;

public class UserBean extends EmployeeBean{
	private String password;
	private String userName;
	private Integer sysLevel;
	private Boolean isActiveDirectory;
	
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
	
	public Integer getSysLevel() {
		return sysLevel;
	}
	
	public void setSysLevel(Integer sysLevel) {
		this.sysLevel = sysLevel;
	}

	public Boolean getIsActiveDirectory() {
		return isActiveDirectory;
	}

	public void setIsActiveDirectory(Boolean isActiveDirectory) {
		this.isActiveDirectory = isActiveDirectory;
	}

}

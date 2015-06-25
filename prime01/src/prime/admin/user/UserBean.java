package prime.admin.user;

import java.util.Date;
import prime.admin.employee.EmployeeBean;

public class UserBean extends EmployeeBean{
	private Boolean isActiveDirectory;
	private Integer sysLevel;
	private String password;
	private String userName;
	private Date changeDate;
	public Date getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}
	private Integer statusUser;
	private Integer employeeId;
	private String employeeName;
	
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
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
	public Integer getStatusUser() {
		return statusUser;
	}
	public void setStatusUser(Integer statusUser) {
		this.statusUser = statusUser;
	}
	
}

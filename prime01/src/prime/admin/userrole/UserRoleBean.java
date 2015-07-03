package prime.admin.userrole;

import prime.admin.usermenu.UserMenuBean;

public class UserRoleBean extends UserMenuBean {

	private Integer userRoleId;
	private String userRoleName;
	private String userRoleDescription;
	private String updateBy;

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public String getUserRoleName() {
		return userRoleName;
	}

	public void setUserRoleName(String userRoleName) {
		this.userRoleName = userRoleName;
	}

	public Integer getUserRoleId() {
		return userRoleId;
	}

	public void setUserRoleId(Integer userRoleId) {
		this.userRoleId = userRoleId;
	}

	public String getUserRoleDescription() {
		return userRoleDescription;
	}

	public void setUserRoleDescription(String userRoleDescription) {
		this.userRoleDescription = userRoleDescription;
	}

}

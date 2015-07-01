package prime.admin.usermenu;

public class UserMenuBean {
	private String userMenuName;
	private Integer userMenuId;
	private String userMenuAction;
	private Boolean isCheck;

	public Boolean getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}

	public String getUserMenuName() {
		return userMenuName;
	}

	public void setUserMenuName(String userMenuName) {
		this.userMenuName = userMenuName;
	}

	public Integer getUserMenuId() {
		return userMenuId;
	}

	public void setUserMenuId(Integer userMenuId) {
		this.userMenuId = userMenuId;
	}

	public String getUserMenuAction() {
		return userMenuAction;
	}

	public void setUserMenuAction(String userMenuAction) {
		this.userMenuAction = userMenuAction;
	}

}

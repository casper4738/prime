package prime.admin.userrole;

import org.apache.struts.action.ActionForm;

public class UserRoleForm extends ActionForm {

	private UserRoleBean userRoleBean = new UserRoleBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private String checkboxTes;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private Boolean isShowAll = true;

	public Boolean getIsShowAll() {
		return isShowAll;
	}

	public void setIsShowAll(Boolean isShowAll) {
		this.isShowAll = isShowAll;
	}

	public UserRoleBean getUserRoleBean() {
		return userRoleBean;
	}

	public void setUserRoleBean(UserRoleBean userRoleBean) {
		this.userRoleBean = userRoleBean;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getColumnSearch() {
		return columnSearch;
	}
	
	public String getColumnSearchReal() {
		if(isShowAll) {
			return "SHOW ALL";
		} else {
			return columnSearch;
		}
	}

	public void setColumnSearch(String columnSearch) {
		this.columnSearch = columnSearch;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCheckboxTes() {
		return checkboxTes;
	}

	public void setCheckboxTes(String checkboxTes) {
		this.checkboxTes = checkboxTes;
	}

	public Integer getGoToPage() {
		return goToPage;
	}

	public void setGoToPage(Integer goToPage) {
		this.goToPage = goToPage;
	}

	public Integer getShowInPage() {
		return showInPage;
	}

	public void setShowInPage(Integer showInPage) {
		this.showInPage = showInPage;
	}

	public Integer getTmpId() {
		return tmpId;
	}

	public void setTmpId(Integer tmpId) {
		this.tmpId = tmpId;
	}

}

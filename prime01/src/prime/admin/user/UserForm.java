package prime.admin.user;

import org.apache.struts.action.ActionForm;

public class UserForm extends ActionForm {

	private UserBean userBean = new UserBean();
	private String  task;
	private String  search;
	private String  columnSearch;
	private String  tmpValue;
	private String  message;
	private String  password;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer employeeId;
	private Integer userRoleId;
	private Boolean isShowAll = true;

	public Boolean getIsShowAll() {
		return isShowAll;
	}

	public void setIsShowAll(Boolean isShowAll) {
		this.isShowAll = isShowAll;
	}

	public String getColumnSearchReal() {
		if (isShowAll) {
			return "SHOW ALL";
		} else {
			return columnSearch;
		}
	}
	
	public UserBean getUserBean() {
		return userBean;
	}
	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
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
	public void setColumnSearch(String columnSearch) {
		this.columnSearch = columnSearch;
	}
	public String getTmpValue() {
		return tmpValue;
	}
	public void setTmpValue(String tmpValue) {
		this.tmpValue = tmpValue;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public Integer getUserRoleId() {
		return userRoleId;
	}
	public void setUserRoleId(Integer userRoleId) {
		this.userRoleId = userRoleId;
	}
	
	
}

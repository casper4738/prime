package prime.admin.user;

import org.apache.struts.action.ActionForm;

public class UserForm extends ActionForm {

	private UserBean userBean = new UserBean();
	private String task;
	private String search;
	private String columnSearch;
	private Integer goToPage = 1;
	private Integer showInPage;

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


}

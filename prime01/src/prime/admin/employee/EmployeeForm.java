package prime.admin.employee;

import org.apache.struts.action.ActionForm;

public class EmployeeForm extends ActionForm {

	private EmployeeBean employeeBean = new EmployeeBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer managerId = 1;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;

	public EmployeeBean getEmployeeBean() {
		return employeeBean;
	}

	public void setEmployeeBean(EmployeeBean employeeBean) {
		this.employeeBean = employeeBean;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getManagerId() {
		return managerId;
	}

	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
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

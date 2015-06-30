package prime.user.report.employees;

import org.apache.struts.action.ActionForm;

import prime.admin.employee.EmployeeBean;
import prime.user.task.TaskBean;

public class ReportEmployeesForm extends ActionForm {
	private ReportEmployeesBean reportEmployeesBean = new ReportEmployeesBean();
	private TaskBean taskBean = new TaskBean();
	private EmployeeBean employeeBean = new EmployeeBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private Integer employeeId;
	public ReportEmployeesBean getReportEmployeesBean() {
		return reportEmployeesBean;
	}
	public void setReportEmployeesBean(ReportEmployeesBean reportEmployeesBean) {
		this.reportEmployeesBean = reportEmployeesBean;
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
	public TaskBean getTaskBean() {
		return taskBean;
	}
	public void setTaskBean(TaskBean taskBean) {
		this.taskBean = taskBean;
	}
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public EmployeeBean getEmployeeBean() {
		return employeeBean;
	}
	public void setEmployeeBean(EmployeeBean employeeBean) {
		this.employeeBean = employeeBean;
	}
	
	
}

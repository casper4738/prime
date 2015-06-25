package prime.user.project;

import org.apache.struts.action.ActionForm;

import prime.admin.employee.EmployeeBean;
import prime.user.task.TaskBean;

public class ProjectForm extends ActionForm {

	private ProjectBean projectBean = new ProjectBean();
	private EmployeeBean employeeBean = new EmployeeBean();
	private TaskBean taskBean = new TaskBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer radioChoose;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private Integer projectId;
	private Integer projectReceiver;
	private Integer projectMemberId;
	private Integer roleId;
	private Integer employeeId;
	private Integer taskId;

	public TaskBean getTaskBean() {
		return taskBean;
	}

	public void setTaskBean(TaskBean taskBean) {
		this.taskBean = taskBean;
	}

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public EmployeeBean getEmployeeBean() {
		return employeeBean;
	}

	public void setEmployeeBean(EmployeeBean employeeBean) {
		this.employeeBean = employeeBean;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
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

	public Integer getRadioChoose() {
		return radioChoose;
	}

	public void setRadioChoose(Integer radioChoose) {
		this.radioChoose = radioChoose;
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

	public ProjectBean getProjectBean() {
		return projectBean;
	}

	public void setProjectBean(ProjectBean projectBean) {
		this.projectBean = projectBean;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getProjectReceiver() {
		return projectReceiver;
	}

	public void setProjectReceiver(Integer projectReceiver) {
		this.projectReceiver = projectReceiver;
	}

	public Integer getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleNumber(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

}

package prime.user.project;

import org.apache.struts.action.ActionForm;

import prime.admin.employee.EmployeeBean;
import prime.user.task.TaskBean;

public class ProjectFormAsHead extends ActionForm {

	private ProjectBean projectBean = new ProjectBean();
	private EmployeeBean employeeBean = new EmployeeBean();
	private TaskBean taskBean = new TaskBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private String tempRoleId;
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
	private Integer divisionId;
	private Integer positionId;
	private Integer countUnderLevel;
	private Integer employeeIdReceiver;
	private Boolean isShowAll = true;
	private java.sql.Date startDate;
	private java.sql.Date untilDate;
	
	private String progressStartDate;
	private String progressEndDate;

	public ProjectFormAsHead() {
		setStartDate(new java.sql.Date(new java.util.Date().getTime()));
		setUntilDate(new java.sql.Date(new java.util.Date().getTime()));
	}

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

	public ProjectBean getProjectBean() {
		return projectBean;
	}

	public void setProjectBean(ProjectBean projectBean) {
		this.projectBean = projectBean;
	}

	public EmployeeBean getEmployeeBean() {
		return employeeBean;
	}

	public void setEmployeeBean(EmployeeBean employeeBean) {
		this.employeeBean = employeeBean;
	}

	public TaskBean getTaskBean() {
		return taskBean;
	}

	public void setTaskBean(TaskBean taskBean) {
		this.taskBean = taskBean;
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

	public String getTempRoleId() {
		return tempRoleId;
	}

	public void setTempRoleId(String tempRoleId) {
		this.tempRoleId = tempRoleId;
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

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public Integer getDivisionId() {
		return divisionId;
	}

	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}

	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	public Integer getEmployeeIdReceiver() {
		return employeeIdReceiver;
	}

	public void setEmployeeIdReceiver(Integer employeeIdReceiver) {
		this.employeeIdReceiver = employeeIdReceiver;
	}

	public java.sql.Date getStartDate() {
		return startDate;
	}

	public void setStartDate(java.sql.Date startDate) {
		this.startDate = startDate;
	}

	public java.sql.Date getUntilDate() {
		return untilDate;
	}

	public void setUntilDate(java.sql.Date untilDate) {
		this.untilDate = untilDate;
	}

	public String getProgressStartDate() {
		return progressStartDate;
	}

	public void setProgressStartDate(String progressStartDate) {
		this.progressStartDate = progressStartDate;
	}

	public String getProgressEndDate() {
		return progressEndDate;
	}

	public void setProgressEndDate(String progressEndDate) {
		this.progressEndDate = progressEndDate;
	}

	public Integer getCountUnderLevel() {
		return countUnderLevel;
	}

	public void setCountUnderLevel(Integer countUnderLevel) {
		this.countUnderLevel = countUnderLevel;
	}

}

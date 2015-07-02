package prime.user.report.project;

import org.apache.struts.action.ActionForm;

import prime.user.task.TaskBean;

public class ReportProjectForm extends ActionForm {
	private ReportProjectBean reportProjectBean = new ReportProjectBean();
	private TaskBean taskBean = new TaskBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private Integer projectId;
	private Boolean isShowAll = true;
	private java.sql.Date startDate;
	private java.sql.Date untilDate;

	public ReportProjectForm() {
		setStartDate(new java.sql.Date(new java.util.Date().getTime()));
		setUntilDate(new java.sql.Date(new java.util.Date().getTime()));
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

	public ReportProjectBean getReportProjectBean() {
		return reportProjectBean;
	}

	public void setReportProjectBean(ReportProjectBean reportProjectBean) {
		this.reportProjectBean = reportProjectBean;
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

}

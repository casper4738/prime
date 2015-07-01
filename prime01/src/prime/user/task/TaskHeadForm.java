package prime.user.task;

import org.apache.struts.action.ActionForm;

import prime.user.activity.ActivityBean;

public class TaskHeadForm extends ActionForm {

	private TaskBean taskBean = new TaskBean();
	private ActivityBean activityBean = new ActivityBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private String activityChangeDate;
	private Integer activityStatus;
	private Integer radioChoose = 1;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer taskId;
	private Integer activityId;
	private Integer taskReceiver;
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

	public TaskBean getTaskBean() {
		return taskBean;
	}

	public void setTaskBean(TaskBean taskBean) {
		this.taskBean = taskBean;
	}

	public ActivityBean getActivityBean() {
		return activityBean;
	}

	public void setActivityBean(ActivityBean activityBean) {
		this.activityBean = activityBean;
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

	public String getActivityChangeDate() {
		return activityChangeDate;
	}

	public void setActivityChangeDate(String activityChangeDate) {
		this.activityChangeDate = activityChangeDate;
	}

	public Integer getActivityStatus() {
		return activityStatus;
	}

	public void setActivityStatus(Integer activityStatus) {
		this.activityStatus = activityStatus;
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

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public Integer getTaskReceiver() {
		return taskReceiver;
	}

	public void setTaskReceiver(Integer taskReceiver) {
		this.taskReceiver = taskReceiver;
	}

}

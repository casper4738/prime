package prime.user.activity;

public class ActivityBean {
	private Integer activityId;
	private Integer taskId;
	private String 	activityName;
	private String 	activityDescription;
	private Integer status;
	private Integer taskAssigner;
	private java.sql.Date changeDate;
	
	public Integer getTaskAssigner() {
		return taskAssigner;
	}
	public void setTaskAssigner(Integer taskAssigner) {
		this.taskAssigner = taskAssigner;
	}
	public java.sql.Date getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(java.sql.Date changeDate) {
		this.changeDate = changeDate;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getActivityId() {
		return activityId;
	}
	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
	public Integer getTaskId() {
		return taskId;
	}
	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getActivityDescription() {
		return activityDescription;
	}
	public void setActivityDescription(String activityDescription) {
		this.activityDescription = activityDescription;
	}
}

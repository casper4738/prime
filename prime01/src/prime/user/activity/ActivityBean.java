package prime.user.activity;

import java.sql.Timestamp;

public class ActivityBean {
	private Integer activityId;
	private Integer taskId;
	private String 	taskName;
	private String 	activityName;
	private String 	activityDescription;
	private String 	activityDetailNote;
	private Integer status;
	private Integer taskAssigner;
	private java.sql.Timestamp changeDate;
	
	public Integer getTaskAssigner() {
		return taskAssigner;
	}
	public void setTaskAssigner(Integer taskAssigner) {
		this.taskAssigner = taskAssigner;
	}
	public Timestamp getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(Timestamp changeDate) {
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
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public String getActivityDetailNote() {
		return activityDetailNote;
	}
	public void setActivityDetailNote(String activityDetailNote) {
		this.activityDetailNote = activityDetailNote;
	}
}

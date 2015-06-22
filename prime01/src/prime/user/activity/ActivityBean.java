package prime.user.activity;

import prime.user.task.TaskBean;

public class ActivityBean extends TaskBean {

	private Integer activityId;
	private Integer activityStatus;
	private String activityName;
	private String activityDescription;
	private String activityChangeNote;
	private java.sql.Timestamp activityChangeDate;

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public Integer getActivityStatus() {
		return activityStatus;
	}

	public void setActivityStatus(Integer activityStatus) {
		this.activityStatus = activityStatus;
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

	public String getActivityChangeNote() {
		return activityChangeNote;
	}

	public void setActivityChangeNote(String activityChangeNote) {
		this.activityChangeNote = activityChangeNote;
	}

	public java.sql.Timestamp getActivityChangeDate() {
		return activityChangeDate;
	}

	public void setActivityChangeDate(java.sql.Timestamp activityChangeDate) {
		this.activityChangeDate = activityChangeDate;
	}

}

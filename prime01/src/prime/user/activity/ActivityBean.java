package prime.user.activity;

import java.util.Date;

import prime.user.task.TaskBean;
import prime.utility.PrimeUtil;

public class ActivityBean extends TaskBean {

	private Integer activityId;
	private Integer activityStatus;
	private String activityName;
	private String activityDescription;
	private String activityChangeNote;
	private Integer activityLastStatus;
	private Date activityChangeDate;

	public ActivityBean() {
		setActivityChangeDate(new Date());
	}

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

	public Integer getActivityLastStatus() {
		return activityLastStatus;
	}

	public void setActivityLastStatus(Integer activityLastStatus) {
		this.activityLastStatus = activityLastStatus;
	}

	public Date getActivityChangeDate() {
		return this.activityChangeDate;
	}

	public void setActivityChangeDate(Date activityChangeDate) {
		this.activityChangeDate = activityChangeDate;
	}
}

package prime.user.task;

import java.sql.Date;

public class TaskBean {

	private Integer taskId;
	private Integer taskAssigner = 0;
	private Integer taskReceiver = 0;
	private Integer projectMemberId = 0;
	private Integer taskStatus;
	private Date taskStartDate;
	private Date taskEstimateDate;
	private Date taskChangeDate;
	private String taskName;
	private String taskDescription;
	private String taskAssignerName;
	private String taskReceiverName;
	private String taskChangeNote;

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public Integer getTaskAssigner() {
		return taskAssigner;
	}

	public void setTaskAssigner(Integer taskAssigner) {
		this.taskAssigner = taskAssigner;
	}

	public Integer getTaskReceiver() {
		return taskReceiver;
	}

	public void setTaskReceiver(Integer taskReceiver) {
		this.taskReceiver = taskReceiver;
	}

	public Integer getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public Integer getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public Date getTaskStartDate() {
		return taskStartDate;
	}

	public void setTaskStartDate(Date taskStartDate) {
		this.taskStartDate = taskStartDate;
	}

	public Date getTaskEstimateDate() {
		return taskEstimateDate;
	}

	public void setTaskEstimateDate(Date taskEstimateDate) {
		this.taskEstimateDate = taskEstimateDate;
	}

	public Date getTaskChangeDate() {
		return taskChangeDate;
	}

	public void setTaskChangeDate(Date taskChangeDate) {
		this.taskChangeDate = taskChangeDate;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getTaskDescription() {
		return taskDescription;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}

	public String getTaskAssignerName() {
		return taskAssignerName;
	}

	public void setTaskAssignerName(String taskAssignerName) {
		this.taskAssignerName = taskAssignerName;
	}

	public String getTaskReceiverName() {
		return taskReceiverName;
	}

	public void setTaskReceiverName(String taskReceiverName) {
		this.taskReceiverName = taskReceiverName;
	}

	public String getTaskChangeNote() {
		return taskChangeNote;
	}

	public void setTaskChangeNote(String taskChangeNote) {
		this.taskChangeNote = taskChangeNote;
	}

}

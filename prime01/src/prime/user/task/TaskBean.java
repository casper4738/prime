package prime.user.task;

import java.sql.Date;

public class TaskBean {
	private Integer taskId;
	private String taskName;
	private Integer taskReceiver;
	private Integer taskAssigner;
	private Date taskStartDate;
	private Date taskEstimateDate;
	private String taskDescription;
	private Integer projectMemberId;

	public Integer getTaskId() {
		return taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public Integer getTaskReceiver() {
		return taskReceiver;
	}

	public void setTaskReceiver(Integer taskReceiver) {
		this.taskReceiver = taskReceiver;
	}

	public Integer getTaskAssigner() {
		return taskAssigner;
	}

	public void setTaskAssigner(Integer taskAssigner) {
		this.taskAssigner = taskAssigner;
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

	public String getTaskDescription() {
		return taskDescription;
	}

	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}

	public Integer getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

}

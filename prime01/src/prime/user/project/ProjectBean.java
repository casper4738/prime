package prime.user.project;

import java.sql.Date;

import prime.admin.employee.EmployeeBean;

public class ProjectBean extends EmployeeBean {
	private Integer projectId;
	private String projectName;
	private Integer projectReceiver;
	private Integer projectAssigner;
	private String projectDescription;
	private Integer projectStatus;
	private Date projectStartDate;
	private Date projectEstimateDate;
	private String roleName;
	private Integer projectMemberId;
	private String projectChangeNote;
	private Date taskStartDate;
	private Date taskEstimateDate;
	private String taskName;
	private String positionName;
	private String taskStatus;
	private String divisionName;
	
	public String getDivisionName() {
		return divisionName;
	}
	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}
	public Date getTaskEstimateDate() {
		return taskEstimateDate;
	}
	public void setTaskEstimateDate(Date taskEstimateDate) {
		this.taskEstimateDate = taskEstimateDate;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}
	public String getTaskAssigner() {
		return taskAssigner;
	}
	public void setTaskAssigner(String taskAssigner) {
		this.taskAssigner = taskAssigner;
	}
	private String taskAssigner;
	public String getProjectChangeNote() {
		return projectChangeNote;
	}
	public void setProjectChangeNote(String projectChangeNote) {
		this.projectChangeNote = projectChangeNote;
	}
	public Integer getProjectId() {
		return projectId;
	}
	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public Integer getProjectReceiver() {
		return projectReceiver;
	}
	public void setProjectReceiver(Integer projectReceiver) {
		this.projectReceiver = projectReceiver;
	}
	public Integer getProjectAssigner() {
		return projectAssigner;
	}
	public void setProjectAssigner(Integer projectAssigner) {
		this.projectAssigner = projectAssigner;
	}
	public String getProjectDescription() {
		return projectDescription;
	}
	public void setProjectDescription(String projectDescription) {
		this.projectDescription = projectDescription;
	}
	public Date getProjectStartDate() {
		return projectStartDate;
	}
	public void setProjectStartDate(Date projectStartDate) {
		this.projectStartDate = projectStartDate;
	}
	public Date getProjectEstimateDate() {
		return projectEstimateDate;
	}
	public void setProjectEstimateDate(Date projectEstimateDate) {
		this.projectEstimateDate = projectEstimateDate;
	}
	public Integer getProjectStatus() {
		return projectStatus;
	}
	public void setProjectStatus(Integer projectStatus) {
		this.projectStatus = projectStatus;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public Integer getProjectMemberId() {
		return projectMemberId;
	}
	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}
	public Date getTaskStartDate() {
		return taskStartDate;
	}
	public void setTaskStartDate(Date taskStartDate) {
		this.taskStartDate = taskStartDate;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	
	
}

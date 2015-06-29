package prime.user.project;

import java.sql.Date;
import java.text.DecimalFormat;

import prime.admin.employee.EmployeeBean;
import prime.admin.role.RoleBean;
import prime.user.task.TaskBean;

public class ProjectBean extends EmployeeBean {

	private Integer projectId;
	private Integer projectReceiver;
	private Integer projectAssigner;
	private Integer projectMemberId;
	private Integer projectMemberStatus;
	private Integer projectStatus;
	private Integer projectLastStatus;
	private Double percentage;
	private String projectDescription;
	private String projectName;
	private String projectChangeNote;
	private String projectAssignerName;
	private String projectReceiverName;
	private Date projectStartDate;
	private Date projectEstimateDate;
	private TaskBean taskBean;
	private RoleBean roleBean;
	private String roleName;
	private Double percentStatus;
	
	public ProjectBean() {
		roleBean = new RoleBean();
		taskBean = new TaskBean();
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

	public Integer getProjectAssigner() {
		return projectAssigner;
	}

	public void setProjectAssigner(Integer projectAssigner) {
		this.projectAssigner = projectAssigner;
	}

	public Integer getProjectMemberId() {
		return projectMemberId;
	}

	public void setProjectMemberId(Integer projectMemberId) {
		this.projectMemberId = projectMemberId;
	}

	public Integer getProjectMemberStatus() {
		return projectMemberStatus;
	}

	public void setProjectMemberStatus(Integer projectMemberStatus) {
		this.projectMemberStatus = projectMemberStatus;
	}

	public Integer getProjectStatus() {
		return projectStatus;
	}

	public void setProjectStatus(Integer projectStatus) {
		this.projectStatus = projectStatus;
	}

	public Integer getProjectLastStatus() {
		return projectLastStatus;
	}

	public void setProjectLastStatus(Integer projectLastStatus) {
		this.projectLastStatus = projectLastStatus;
	}

	public Double getPercentage() {
		return percentage;
	}
	
	public void setPercentage(Double percentage) {
		this.percentage = percentage;
	}

	public String getProjectDescription() {
		return projectDescription;
	}

	public void setProjectDescription(String projectDescription) {
		this.projectDescription = projectDescription;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectChangeNote() {
		return projectChangeNote;
	}

	public void setProjectChangeNote(String projectChangeNote) {
		this.projectChangeNote = projectChangeNote;
	}

	public String getProjectAssignerName() {
		return projectAssignerName;
	}

	public void setProjectAssignerName(String projectAssignerName) {
		this.projectAssignerName = projectAssignerName;
	}

	public String getProjectReceiverName() {
		return projectReceiverName;
	}

	public void setProjectReceiverName(String projectReceiverName) {
		this.projectReceiverName = projectReceiverName;
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

	public TaskBean getTaskBean() {
		return taskBean;
	}

	public void setTaskBean(TaskBean taskBean) {
		this.taskBean = taskBean;
	}

	public RoleBean getRoleBean() {
		return roleBean;
	}

	public void setRoleBean(RoleBean roleBean) {
		this.roleBean = roleBean;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Double getPercentStatus() {
		return percentStatus;
	}

	public void setPercentStatus(Double percentStatus) {
		this.percentStatus = percentStatus;
	}

}

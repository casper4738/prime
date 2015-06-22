package prime.user.project;

import java.sql.Date;

public class ProjectBean {
	private Integer projectId;
	private String projectName;
	private Integer projectReceiver;
	private Integer projectAssigner;
	private String projectDescription;
	private String projectStatus;
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
	private Date projectStartDate;
	private Date projectEstimateDate;
	
}
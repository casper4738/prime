package prime.user.report.employees;

import prime.admin.employee.EmployeeBean;

public class ReportEmployeesBean extends EmployeeBean {
	private String projectName;

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
}

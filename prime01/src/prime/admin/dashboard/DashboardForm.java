package prime.admin.dashboard;

import org.apache.struts.action.ActionForm;


public class DashboardForm extends ActionForm {
private Integer year;
private Integer  employeeId;

public Integer getYear() {
	return year;
}

public void setYear(Integer year) {
	this.year = year;
}

public Integer getEmployeeId() {
	return employeeId;
}

public void setEmployeeId(Integer employeeId) {
	this.employeeId = employeeId;
}
}
  
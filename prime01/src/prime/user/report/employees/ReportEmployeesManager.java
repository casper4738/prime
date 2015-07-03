package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

import prime.user.task.TaskBean;

public interface ReportEmployeesManager {
	public List<ReportEmployeesBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer empId) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value, Integer empId) throws SQLException;
	
	public ReportEmployeesBean getEmployeeById(Integer id) throws SQLException;	
	

	/*Task View Report*/
	public List<TaskBean> getListEmployeeTaskReport(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer empId) throws SQLException;

	public Integer getCountListEmployeeTaskReport(String columnSearch, String value, Integer empId) throws SQLException;
	/*End Task View Report*/
	
}


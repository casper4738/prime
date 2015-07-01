package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

import prime.user.task.TaskBean;

public interface ReportEmployeesManager {
	public List<ReportEmployeesBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public ReportEmployeesBean getEmployeeById(Integer id) throws SQLException;
	
	public List<TaskBean> getListByColumnSubordinate(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer taskReceiver) throws SQLException;
}


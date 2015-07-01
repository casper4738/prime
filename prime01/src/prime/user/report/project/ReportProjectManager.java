package prime.user.report.project;

import java.sql.SQLException;
import java.util.List;

import prime.user.report.employees.ReportEmployeesBean;

public interface ReportProjectManager {
	public List<ReportProjectBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public ReportProjectBean getProjectById(Integer id) throws SQLException;
}

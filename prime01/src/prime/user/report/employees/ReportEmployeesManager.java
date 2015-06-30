package prime.user.report.employees;

import java.sql.SQLException;
import java.util.List;

public interface ReportEmployeesManager {
	public List<ReportEmployeesBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
}


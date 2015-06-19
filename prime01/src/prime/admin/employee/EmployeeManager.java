package prime.admin.employee;

import java.sql.SQLException;
import java.util.List;

import prime.admin.employee.EmployeeBean;

public interface EmployeeManager {
	public void insert(EmployeeBean e) throws SQLException;
	
	public void update(EmployeeBean e) throws SQLException;
	
	public void delete(Integer id) throws SQLException;
	
	public EmployeeBean getEmployeeById(Integer id) throws SQLException;
	
	public List<EmployeeBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<EmployeeBean> getListByColumnAndDivision(String columnSearch, String value, Integer divisionId, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;

	public Integer getCountByColumnAndDivision(String columnSearch, String value, Integer divisionId) 
			throws SQLException;
	
	public Integer getNewId() throws SQLException;
}
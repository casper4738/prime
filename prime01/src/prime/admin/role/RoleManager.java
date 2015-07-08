package prime.admin.role;

import java.sql.SQLException;
import java.util.List;

public interface RoleManager {

	public void insert(RoleBean e) throws SQLException;
	
	public void update(RoleBean e) throws SQLException;
	
	public void delete(Integer id) throws SQLException;
	
	public RoleBean getRoleById(Integer id) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public List<RoleBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<RoleBean> getRolesByEmployeeIdAndProjectId(Integer employeeId, Integer projectId) throws SQLException;
	
	public List<RoleBean> getListAllRole() throws SQLException;
	
	public Integer getRoleUsed(Integer roleId) throws SQLException;
}

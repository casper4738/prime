package prime.admin.userrole;

import java.sql.SQLException;
import java.util.List;

public interface UserRoleManager {
	
	public void insert(UserRoleBean e) throws SQLException;
	
	public void insertUserRoleMenu(UserRoleBean e) throws SQLException;
	
	public void update(UserRoleBean e) throws SQLException;
	
	public void delete(Integer id) throws SQLException;

	public Integer getNewId() throws SQLException;

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;

	public UserRoleBean getUserRoleById(Integer id) throws SQLException;
	
	public List<UserRoleBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<UserRoleBean> getListAll() throws SQLException;
		
}

package prime.admin.userrole;

import java.sql.SQLException;
import java.util.List;

import prime.admin.usermenu.UserMenuBean;

public interface UserRoleManager {
	
	public void insert(UserRoleBean e) throws SQLException;
	
	public void update(UserRoleBean e) throws SQLException;
	
	public Integer getNewId() throws SQLException;

	public UserRoleBean getUserRoleById(Integer id) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public List<UserRoleBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<UserRoleBean> getListAll() throws SQLException;
	
	public List<UserMenuBean> getListUserMenuByUserRoleId(Integer id) throws SQLException;
}

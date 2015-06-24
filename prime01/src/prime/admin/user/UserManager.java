package prime.admin.user;

import java.sql.SQLException;
import java.util.List;

import prime.admin.user.UserBean;

public interface UserManager {
	public void insert(UserBean e) throws SQLException;
	
	public void update(UserBean e) throws SQLException;
	
	public void delete(String username) throws SQLException;
	
	public UserBean getUserByUsername(String username) throws SQLException;
	
	public List<UserBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public void resetPassword(UserBean e) throws SQLException;
	
	public void lockUser(UserBean e) throws SQLException;
}

package prime.admin.usermenu;

import java.sql.SQLException;
import java.util.List;

public interface UserMenuManager {
	
	public List<UserMenuBean> getListAll() throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public List<UserMenuBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
}

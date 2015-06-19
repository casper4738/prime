package prime.user.activity;

import java.sql.SQLException;
import java.util.List;

public interface ActivityManager {
	public List<ActivityBean> getToDoListById(Integer id) throws SQLException;
	public List<ActivityBean> getListActivityById(Integer id, Integer startRow, Integer endRow) throws SQLException;
	
	public List<ActivityBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
}

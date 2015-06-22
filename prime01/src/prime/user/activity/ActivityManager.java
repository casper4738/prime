package prime.user.activity;

import java.sql.SQLException;
import java.util.List;

import prime.admin.division.DivisionBean;

public interface ActivityManager {
	public List<ActivityBean> getToDoListById(Integer id) throws SQLException;
	
	public List<ActivityBean> getCurrentListActivity(Integer id,String currentDate) throws SQLException;
	
	public List<ActivityBean> getActivityRangeTime(Integer id) throws SQLException;
	
	public void insertToDoList(Integer receiverId, Integer activityId) throws SQLException;
	
	public void deleteToDoList(Integer receiverId, Integer activityId) throws SQLException;
	
	public void insertActivityDetail(Integer receiverId, Integer activityId, Integer status, String activityDetailNote) throws SQLException;
	
	public List<ActivityBean> getListActivityById(Integer id, String columnSearch,
			String value, Integer startRow, Integer endRow) throws SQLException;
	
	public List<ActivityBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountToDoListById(Integer receiverId, String columnSearch, String value) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
}

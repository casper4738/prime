package prime.user.activity;

import java.sql.SQLException;
import java.util.List;

public interface ActivityManager {
	
	public void insert(ActivityBean e) throws SQLException;
	
	public void insertDetail(ActivityBean e) throws SQLException;
	
	public void update(ActivityBean e) throws SQLException;
	
	public ActivityBean getActivityById(Integer id) throws SQLException;
	
	public ActivityBean getActivityDetailById(Integer activityId, String activityChangeDate) throws SQLException;
	
	public List<ActivityBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId)
			throws SQLException;
	
	public List<ActivityBean> getListActivityDetail(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer activityId) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value, Integer taskId) throws SQLException;

	public Integer getNewId() throws SQLException;

	public Boolean isAllFinished(Integer taskId) throws SQLException;
	

	
	
	
	
	public List<ActivityBean> getToDoListById(Integer id) throws SQLException;
	
	public List<ActivityBean> getCurrentListActivity(Integer id,String currentDate) throws SQLException;
	
	public List<ActivityBean> getActivityRangeTime(Integer id) throws SQLException;
	
	public void insertToDoList(Integer receiverId, Integer activityId) throws SQLException;
	
	public void deleteToDoList(Integer receiverId, Integer activityId) throws SQLException;
	
	public void insertActivityDetail(Integer receiverId, Integer activityId, Integer status, String activityDetailNote) throws SQLException;

	public List<ActivityBean> getListActivityById(Integer id, String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException;
	
	public Integer getCountToDoListById(Integer receiverId, String columnSearch, String value) throws SQLException;
	
	public Integer getCountActivityDetail(String columnSearch, String value, Integer activityId) throws SQLException;
}

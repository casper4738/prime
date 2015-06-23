package prime.user.activity;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ActivityManagerImpl implements ActivityManager {

	private SqlMapClient mapper;

	public ActivityManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	@Override
	public void insert(ActivityBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("activity.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	

	@Override
	public void insertDetail(ActivityBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("activity.insertDetail", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	@Override
	public void update(ActivityBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("activity.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public List<ActivityBean> getToDoListById(Integer id) throws SQLException {
		return mapper.queryForList("activity.getToDoListById", id);
	}


	@Override
	public ActivityBean getActivityById(Integer id) throws SQLException {
		return (ActivityBean) mapper.queryForObject("activity.get", id);
	}
	
	@Override
	public ActivityBean getActivityDetailById(Integer activityId, String activityChangeDate) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("activityId", activityId);
		map.put("activityChangeDate", activityChangeDate);
		return (ActivityBean) mapper.queryForObject("activity.getDetail", map);
	}
	
	public List<ActivityBean> getListActivityDetail(String columnSearch, String value, Integer startRow, Integer endRow, Integer activityId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("activityId", activityId);
		return mapper.queryForList("activity.getListActivityDetail", map);
	}
	

	public Integer getCountActivityDetail(String columnSearch, String value,Integer activityId)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("activityId", activityId);
		return (Integer) mapper.queryForObject("activity.getCountActivityDetail",map);
	}

	public List<ActivityBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("taskId", taskId);
		return mapper.queryForList("activity.getListByColumn", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("activity.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value, Integer taskId)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("taskId", taskId);
		return (Integer) mapper.queryForObject("activity.getCountByColumn",map);
	}
	
	
	public Boolean isAllFinished(Integer taskId) throws SQLException {
		return (Boolean) mapper.queryForObject("activity.isAllFinished",taskId);
	}

	@Override
	public List<ActivityBean> getListActivityById(Integer id, String columnSearch,
			String value, Integer startRow, Integer endRow)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("activity.getListByEmployeeId", map);
	}

	@Override
	public List<ActivityBean> getCurrentListActivity(Integer id,String currentDate)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("currentDate", currentDate);
		System.out.println("currentDate" + currentDate);
		return mapper.queryForList("activity.getCurrentListActivity", map);
	}
	
	@Override
	public void insertToDoList(Integer receiverId, Integer activityId) throws SQLException {
		// TODO Auto-generated method stub
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("receiverId", receiverId);
			map.put("activityId", activityId);
			mapper.startTransaction();
			mapper.insert("activity.insertToDoList", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	@Override
	public Integer getCountToDoListById(Integer receiverId, String columnSearch, String value)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("receiverId", receiverId);
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("activity.getCountToDoListById",map);
	}

	public void deleteToDoList(Integer receiverId, Integer activityId) throws SQLException {
		// TODO Auto-generated method stub
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("receiverId", receiverId);
			map.put("activityId", activityId);
			mapper.startTransaction();
			mapper.insert("activity.deleteToDoList", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	@Override
	public void insertActivityDetail(Integer receiverId, Integer activityId, Integer status, String activityDetailNote)
			throws SQLException {
		// TODO Auto-generated method stub
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("receiverId", receiverId);
			map.put("activityId", activityId);
			map.put("status", status);
			map.put("activityDetailNote", activityDetailNote);
			mapper.startTransaction();
			mapper.insert("activity.insertActivityDetail", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	@Override
	public List<ActivityBean> getActivityRangeTime(Integer activityId)
			throws SQLException {
		// TODO Auto-generated method stub
		return mapper.queryForList("activity.getRangeTimeByActivityId", activityId);
	}
}

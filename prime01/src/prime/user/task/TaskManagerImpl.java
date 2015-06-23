package prime.user.task;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class TaskManagerImpl implements TaskManager {
	private SqlMapClient mapper;

	public TaskManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	@Override
	public void insert(TaskBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("task.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	@Override
	public void insertDetail(TaskBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("task.insertDetail", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	@Override
	public TaskBean getTaskById(Integer id) throws SQLException {
		return (TaskBean) mapper.queryForObject("task.get", id);
	}
	
	@Override
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("task.getNewId", null);
	}

	/*Task Head*/
	@Override
	public List<TaskBean> getListByColumnHead(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer taskAssigner) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("taskAssigner", taskAssigner);
		return mapper.queryForList("task.getListByColumnHead", map);
	}

	@Override
	public Integer getCountByColumnHead(String columnSearch, String value, Integer taskAssigner) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("taskAssigner", taskAssigner);
		return (Integer) mapper.queryForObject("task.getCountByColumnHead", map);
	}
	/*End Task Head*/
	
	/*Task Subordinate*/
	@Override
	public List<TaskBean> getListByColumnSubordinate(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer taskReceiver) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("taskReceiver", taskReceiver);
		return mapper.queryForList("task.getListByColumnSubordinate", map);
	}

	@Override
	public Integer getCountByColumnSubordinate(String columnSearch, String value, Integer taskReceiver) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("taskReceiver", taskReceiver);
		return (Integer) mapper.queryForObject("task.getCountByColumnSubordinate", map);
	}
	/*End Task Subordinate*/


}

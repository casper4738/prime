package prime.user.task;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.constants.Constants;
import prime.user.project.ProjectBean;
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
	public void insertDetailBySelectTask(TaskBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("task.insertDetailBySelectTask", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	@Override
	public void updateActualStart(Integer taskId, java.sql.Date actualStart) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("taskId", taskId);
			map.put("actualStart", actualStart);
			
			mapper.startTransaction();
			mapper.update("task.updateActualStart", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	@Override
	public void updateActualEnd(Integer taskId, java.sql.Date actualEnd) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("taskId", taskId);
			map.put("actualEnd", actualEnd);
			
			mapper.startTransaction();
			mapper.update("task.updateActualEnd", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void updateMainDays(Integer taskId, Integer mainDays) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("taskId", taskId);
			map.put("mainDays", mainDays);
			
			mapper.startTransaction();
			mapper.update("task.updateActualMainDays", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	@Override
	public TaskBean getTaskById(Integer id) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("finish", Constants.Status.FINISH);
		map.put("abort", Constants.Status.ABORT);
		return (TaskBean) mapper.queryForObject("task.get", map);
	}
	
	@Override
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("task.getNewId", null);
	}

	@Override
	public Boolean isCheckStatus(Integer taskId, Integer status) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("taskId", taskId);
		map.put("status", status);
		return (Boolean) mapper.queryForObject("task.isCheckStatus",map);
	}
	
	@Override
	public Boolean isCheckStatusDetail(Integer taskId, Integer status) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("taskId", taskId);
		map.put("status", status);
		return (Boolean) mapper.queryForObject("task.isCheckStatusDetail",map);
	}
	
	@Override
	public List<TaskBean> getListByProjectId(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("projectId", projectId);
		map.put("finish", Constants.Status.FINISH);
		map.put("abort", Constants.Status.ABORT);
		return mapper.queryForList("task.getListByProjectId", map);
	}

	@Override
	public Integer getCountListByProjectId(String columnSearch, String value, Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		map.put("projectId", projectId);
		return (Integer) mapper.queryForObject("task.getCountListByProjectId", map);
	}
	
	/*Task Head*/
	@Override
	public List<TaskBean> getListByColumnHead(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer taskAssigner) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("taskAssigner", taskAssigner);
		map.put("finish", Constants.Status.FINISH);
		map.put("abort", Constants.Status.ABORT);
		return mapper.queryForList("task.getListByColumnHead", map);
	}

	@Override
	public Integer getCountByColumnHead(String columnSearch, String value, Integer taskAssigner) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
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
		map.put("finish", Constants.Status.FINISH);
		map.put("abort", Constants.Status.ABORT);
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

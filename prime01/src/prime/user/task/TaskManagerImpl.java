package prime.user.task;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.division.DivisionBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class TaskManagerImpl implements TaskManager {
	private SqlMapClient mapper;

	public TaskManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	@Override
	public void insert(TaskBean e) throws SQLException {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		return (TaskBean) mapper.queryForObject("task.get", id);
	}

	@Override
	public List<TaskBean> getListByColumn(String columnSearch, String value,
			Integer startRow, Integer endRow) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("task.getListByColumn", map);
	}

	@Override
	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("task.getCountListByCol", map);
	}

	@Override
	public Integer getNewId() throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("task.getNewId", null);
	}

}

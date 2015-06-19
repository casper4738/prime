package prime.user.activity;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.division.DivisionBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ActivityManagerImpl implements ActivityManager {

	private SqlMapClient mapper;

	public ActivityManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public List<ActivityBean> getToDoListById(Integer id) throws SQLException {
		return mapper.queryForList("activity.", id);
	}

	public List<ActivityBean> getListByColumn(String columnSearch,
			String value, Integer startRow, Integer endRow) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("activity.getListByCol", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("activity.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("activity.getCountListByCol",
				map);
	}

	@Override
	public List<ActivityBean> getListActivityById(Integer id, Integer startRow, Integer endRow)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("activity.getListByEmployeeId", map);
	}


}
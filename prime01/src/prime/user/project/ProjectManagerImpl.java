package prime.user.project;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;


import prime.utility.IbatisHelper;

public class ProjectManagerImpl implements ProjectManager {
	private SqlMapClient mapper;
	
	public ProjectManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	@Override
	public List<ProjectBean> getListByColumn(String columnSearch, String value,
			Integer startRow, Integer endRow) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("project.getListByCol", map);
	}

	@Override
	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("project.getCountListByCol", map);
	}
	
}

package prime.admin.log;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class LogManagerImpl implements LogManager{

private SqlMapClient mapper;

public LogManagerImpl() {
	mapper = IbatisHelper.getSqlMapInstance();
}
	
	public List<LogBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("log.getListByCol", map);
	}
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch+"");
		map.put("value", value+"");
		return  (Integer) mapper.queryForObject("log.getCountListByCol", map);
	}
}

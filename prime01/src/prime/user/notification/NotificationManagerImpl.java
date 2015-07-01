package prime.user.notification;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class NotificationManagerImpl implements NotificationManager{

	private SqlMapClient mapper;

	public NotificationManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	public List<NotificationBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		return mapper.queryForList("notification.getListByCol", map);
	}
	
	public Integer getCountByColumn(String columnSearch, String value, Integer employeeId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("employeeId", employeeId);
		return  (Integer) mapper.queryForObject("notification.getCountListByCol", map);
	}
	
	public List<NotificationBean> getListNotifNoRead(Integer employeeId) throws SQLException {
		return mapper.queryForList("notification.getListNotifNoRead", employeeId);
	}
	
	public Integer getCountListNotifNoRead(Integer employeeId) throws SQLException {
		return  (Integer) mapper.queryForObject("notification.getCountListNotifNoRead", employeeId);
	}
}

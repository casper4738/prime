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

	public void insert(int notifId, int notifType, String notifValue, int senderId,
			int receiverId, String notifLink) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("notifId"		, notifId);
			map.put("notifType"		, notifType);
			map.put("notifValue"	, notifValue);			
			map.put("senderId"		, senderId);
			map.put("receiverId"	, receiverId);
			map.put("notifLink"		, notifLink);

			mapper.startTransaction();
			mapper.insert("notification.insert", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
		
	}
	
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("notification.getNewId", null);
	}

	@Override
	public void markAsRead(Integer notifId) throws SQLException {
		mapper.startTransaction();
		mapper.update("notification.markAsRead", notifId);
		mapper.commitTransaction();	
	}

	@Override
	public NotificationBean getNotifByID(Integer notifId) throws SQLException {
		return (NotificationBean) mapper.queryForObject("notification.getNotifByID", notifId);
	}
}

package prime.user.notification;

import java.sql.SQLException;
import java.util.List;


public interface NotificationManager {

	public List<NotificationBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) throws SQLException;
	
	public List<NotificationBean> getListNotifNoRead(Integer employeeId) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value, Integer employeeId) throws SQLException;
	
	public Integer getCountListNotifNoRead(Integer employeeId) throws SQLException;
	
	public void insert(int notifId, int notifType, String notifValue, int senderId, int receiverId, String notifLink) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public void markAsRead(Integer notifId) throws SQLException;
	
	public NotificationBean getNotifByID(Integer notifId) throws SQLException;
}

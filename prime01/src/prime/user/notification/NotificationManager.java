package prime.user.notification;

import java.sql.SQLException;
import java.util.List;


public interface NotificationManager {

	public List<NotificationBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) throws SQLException;
	
	public List<NotificationBean> getListNotifNoRead(Integer employeeId) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value, Integer employeeId) throws SQLException;
	
	public Integer getCountListNotifNoRead(Integer employeeId) throws SQLException;
}

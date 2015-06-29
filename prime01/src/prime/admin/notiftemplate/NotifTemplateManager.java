package prime.admin.notiftemplate;

import java.sql.SQLException;
import java.util.List;

import prime.admin.notiftemplate.NotifTemplateBean;

public interface NotifTemplateManager {
	public void insert(NotifTemplateBean e) throws SQLException;
	
	public void update(NotifTemplateBean e) throws SQLException;
	
	public NotifTemplateBean getNotifTemplateById(Integer id) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public List<NotifTemplateBean> getListByColumn(Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn() throws SQLException;

}

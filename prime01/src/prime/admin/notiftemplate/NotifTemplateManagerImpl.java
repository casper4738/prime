package prime.admin.notiftemplate;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class NotifTemplateManagerImpl implements NotifTemplateManager{
	private SqlMapClient mapper;

	public NotifTemplateManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	public void insert(NotifTemplateBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("notiftemplate.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void update(NotifTemplateBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("notiftemplate.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public NotifTemplateBean getNotifTemplateById(Integer id) throws SQLException {
		return (NotifTemplateBean) mapper.queryForObject("notiftemplate.get", id);
	}
	
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("notiftemplate.getNewId", null);
	}
	
	public List<NotifTemplateBean> getListByColumn(Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("notiftemplate.getListByColumn", map);
	}
	
	public Integer getCountByColumn() throws SQLException {
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);*/
		return (Integer) mapper.queryForObject("notiftemplate.getCountByColumn", null);
	}
}

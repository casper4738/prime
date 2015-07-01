package prime.admin.usermenu;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class UserMenuManagerImpl implements UserMenuManager{
	private SqlMapClient mapper;

	public UserMenuManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	public List<UserMenuBean> getListAll() throws SQLException {
		return mapper.queryForList("usermenu.selectAll", null);
	}
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("usermenu.getCountListByCol", map);
	}
	
	public List<UserMenuBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("usermenu.getListByCol", map);
	}
	
	public List<UserMenuBean> getListUserMenuByUserRoleId(Integer id) throws SQLException {
		return mapper.queryForList("usermenu.getMenu", id);
	}

}

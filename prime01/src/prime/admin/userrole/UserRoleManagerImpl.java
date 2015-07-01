package prime.admin.userrole;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.division.DivisionBean;
import prime.admin.employee.EmployeeBean;
import prime.admin.usermenu.UserMenuBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class UserRoleManagerImpl implements UserRoleManager{
	private SqlMapClient mapper;

	public UserRoleManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	public void insert(UserRoleBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("userrole.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void insertUserRoleMenu(UserRoleBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("userrole.insertUserRoleMenu", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(UserRoleBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("userrole.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	

	public void delete(Integer id) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.delete("userrole.deleteUserRoleMenu", id);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("userrole.getNewId", null);
	}
	
	public UserRoleBean getUserRoleById(Integer id) throws SQLException {
		return (UserRoleBean) mapper.queryForObject("userrole.get", id);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("userrole.getCountListByCol", map);
	}
	
	public List<UserRoleBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("userrole.getListByCol", map);
	}

	public List<UserRoleBean> getListAll() throws SQLException {
		return mapper.queryForList("userrole.selectAll", null);
	}
	
	
}

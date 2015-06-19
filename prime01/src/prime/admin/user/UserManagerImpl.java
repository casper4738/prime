package prime.admin.user;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import prime.admin.user.UserBean;
import prime.admin.user.UserManager;
import prime.utility.IbatisHelper;

public class UserManagerImpl implements UserManager {
	private SqlMapClient mapper;
	
	public UserManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("user.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(String username) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			mapper.delete("user.delete", username);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public UserBean getEmployeeById(Integer id) throws SQLException {
		return (UserBean) mapper.queryForObject("employee.get", id);
	}

	public List<UserBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return mapper.queryForList("user.getListByColumn", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("employee.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("user.getCountByColumn", map);
	}
}

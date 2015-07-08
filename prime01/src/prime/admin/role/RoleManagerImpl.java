package prime.admin.role;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class RoleManagerImpl implements RoleManager {

	private SqlMapClient mapper;
	
	public RoleManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(RoleBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("role.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(RoleBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("role.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(Integer id) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.delete("role.delete", id);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public RoleBean getRoleById(Integer id) throws SQLException {
		return (RoleBean) mapper.queryForObject("role.get", id);
	}

	public List<RoleBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("role.getListByCol", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("role.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("role.getCountListByCol", map);
	}

	@Override
	public List<RoleBean> getRolesByEmployeeIdAndProjectId(Integer employeeId, Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return mapper.queryForList("role.getRolesByEmployeeIdAndProjectId", map);
	}
	
	@Override
	public List<RoleBean> getListAllRole() throws SQLException {
		return mapper.queryForList("role.selectAll", null);
	}

	@Override
	public Integer getRoleUsed(Integer roleId) throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("role.getRoleUsed", roleId);
	}
	
}

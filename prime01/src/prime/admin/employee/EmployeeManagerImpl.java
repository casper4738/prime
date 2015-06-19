
package prime.admin.employee;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class EmployeeManagerImpl implements EmployeeManager {
	private SqlMapClient mapper;
	
	public EmployeeManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("employee.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("employee.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(Integer id) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			mapper.delete("employee.delete", id);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public EmployeeBean getEmployeeById(Integer id) throws SQLException {
		return (EmployeeBean) mapper.queryForObject("employee.get", id);
	}

	public List<EmployeeBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("employee.getListByCol", map);
	}
	

	public List<EmployeeBean> getListByColumnAndDivision(String columnSearch, String value, Integer divisionId, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("divisionId", divisionId);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("employee.getListByColumnAndDivision", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("employee.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("employee.getCountListByCol", map);
	}
	
	public Integer getCountByColumnAndDivision(String columnSearch, String value, Integer divisionId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("divisionId", divisionId);
		return (Integer) mapper.queryForObject("employee.getCountByColumnAndDivision", map);
	}
}
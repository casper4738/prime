
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
	
	public void insertResign(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("employee.insertResign", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void updateStatusUser(Integer employeeId) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("employee.updateStatusUser", employeeId);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void insertWeekend(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("employee.insertWeekend", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void insertDayoff(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("employee.insertDayoff", e);
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
	
	public void updatePositionDivision(EmployeeBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("employee.updatePositionDivision", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void updateHead(Integer forCondition, Integer newHead) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("forCondition", forCondition);
			map.put("newHead", newHead);
			mapper.startTransaction();
			mapper.update("employee.updateHead", map);
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
	
	public List<EmployeeBean> getListWeekendByEmployeeId(Integer id) throws SQLException {
		return mapper.queryForList("employee.getWeekend", id);
	}
	
	public List<EmployeeBean> getListDayoffByEmployeeId(Integer id) throws SQLException {
		return mapper.queryForList("employee.getDayoff", id);
	}

	public List<EmployeeBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("employee.getListByColumn", map);
	}
	
	public List<EmployeeBean> getListEmployeeHead(String columnSearch, String value, Integer positionLevel, Integer startRow, Integer endRow, String paramCondition, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);		
		map.put("positionLevel", positionLevel);
		map.put("paramCondition", paramCondition);
		map.put("employeeId", employeeId);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("employee.getListEmployeeHead", map);
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
	

	/*select employee by tree and division and level  */
	public List<EmployeeBean> getListByTreeWithDivision(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		return mapper.queryForList("employee.getListByTreeWithDivision", map);
	}

	public Integer getCountListByTreeWithDivision(String columnSearch, String value, Integer employeeId)  throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		return (Integer) mapper.queryForObject("employee.getCountListByTreeWithDivision", map);
	}
	/* end select employee by tree and division and level  */
	
	/*select employee by tree and level  */
	public List<EmployeeBean> getListByTreeWithoutDivision(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		return mapper.queryForList("employee.getListByTreeWithoutDivision", map);
	}

	public Integer getCountListByTreeWithoutDivision(String columnSearch, String value, Integer employeeId)  throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		return (Integer) mapper.queryForObject("employee.getCountListByTreeWithoutDivision", map);
	}
	/* end select employee by tree and level  */
	
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("employee.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("employee.getCountByColumn", map);
	}
	
	public Integer getCountByColumnEmployeeHead(String columnSearch, String value, Integer positionLevel, String paramCondition, Integer employeeId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("positionLevel", positionLevel);
		map.put("paramCondition", paramCondition);
		map.put("employeeId", employeeId);
		map.put("value", value);
		return (Integer) mapper.queryForObject("employee.getCountByColumnEmployeeHead", map);
	}
	
	public Integer getCountByColumnAndDivision(String columnSearch, String value, Integer divisionId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("divisionId", divisionId);
		return (Integer) mapper.queryForObject("employee.getCountByColumnAndDivision", map);
	}

	@Override
	public EmployeeBean getEmployeeWeekendByIdAndStartFrom(Integer id,
			String startFrom) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("startFrom", startFrom);
		return (EmployeeBean) mapper.queryForObject("employee.getEmployeeWeekendByIdAndStartFrom", map);
	}

	@Override
	/*public void updateWeekend(EmployeeBean e) throws SQLException {
		// TODO Auto-generated method stub
		try {
			System.out.println(e.getStartFrom()+"--");
			mapper.startTransaction();
			mapper.update("employee.updateWeekend", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}*/

	public void deleteDayOff(Integer id, String startDate) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("startDate", startDate);
			mapper.delete("employee.deleteDayOff", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void deleteWeekEnd(Integer id, String startFrom) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("startFrom", startFrom);
			mapper.delete("employee.deleteWeekEnd", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
}

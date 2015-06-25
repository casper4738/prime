
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
			System.out.println(employeeId+ "  EMPLOYEEID");
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
			System.out.println("CEK");
			mapper.startTransaction();
			mapper.insert("employee.insertDayoff", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void update(EmployeeBean e) throws SQLException {
		try {
			System.out.println(e.getEmployeeId()+"--EmpID");
			System.out.println(e.getEmployeeName()+"--Name");
			System.out.println(e.getAddress()+"--Address");
			System.out.println(e.getContactNumber()+"--Numb");
			System.out.println(e.getEmail()+"--Email");
			System.out.println(e.getBirthdate()+"--Birth");
			System.out.println(e.getGender()+"--Gender");
			System.out.println(e.getHireDate()+"--HireDate");
			System.out.println(e.getDivisionId()+"--Division");
			System.out.println(e.getPositionId()+"--Position");
			System.out.println(e.getManagerId()+"--Manager");
			mapper.startTransaction();
			mapper.update("employee.update", e);
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

	
}

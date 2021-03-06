
package prime.admin.employee;

import java.sql.Date;
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
	
	public List<EmployeeBean> getListEmployeeHead(String columnSearch, String value, Integer positionLevel, Integer startRow, Integer endRow, String paramCondition, Integer employeeId, Integer divisionId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);		
		map.put("positionLevel", positionLevel);
		map.put("paramCondition", paramCondition);
		map.put("employeeId", employeeId);
		map.put("divisionId", divisionId);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		System.out.println("columnSearch"+ columnSearch);
		System.out.println("value"+ value);
		System.out.println("positionLevel"+ positionLevel);
		System.out.println("paramCondition"+ paramCondition);
		System.out.println("employeeId"+ employeeId);
		System.out.println("divisionId"+ divisionId);
		System.out.println("startRow"+ startRow);
		System.out.println("endRow"+ endRow);
		
		return mapper.queryForList("employee.getListEmployeeHead", map);
	}

	/* NOT USE NOW
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
	
	public Integer getCountByColumnAndDivision(String columnSearch, String value, Integer divisionId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("divisionId", divisionId);
		return (Integer) mapper.queryForObject("employee.getCountByColumnAndDivision", map);
	}
	*/

	/*select employee by tree */
	public List<EmployeeBean> getListByTree(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		return mapper.queryForList("employee.getListByTree", map);
	}

	public Integer getCountListByTree(String columnSearch, String value, Integer employeeId)  throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		return (Integer) mapper.queryForObject("employee.getCountListByTree", map);
	}
	/* end of select employee by tree */
	
	
	//get member tree
	@Override
	public List<EmployeeBean> getListTreeforMember(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer employeeId, Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		
		return mapper.queryForList("employee.getListTreeforMember", map);
	}
	
	public Integer getCountListByTreeforMember(String columnSearch, String value, Integer employeeId, Integer projectId)  throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return (Integer) mapper.queryForObject("employee.getCountListByTree", map);
	}
	
	
	
	
	@Override
	public List<EmployeeBean> getListTreeforChangePM(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId, Integer idOldPM)  throws SQLException {
		System.out.println("emp "+employeeId);
		System.out.println("old "+idOldPM);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		map.put("idOldPM", idOldPM);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		System.out.println("emp "+employeeId);
		System.out.println("old "+idOldPM);
		System.out.println("columnSearch "+columnSearch);
		System.out.println("value "+value);
		return mapper.queryForList("employee.getListTreeforChangePM", map);
	}

	
	
	@Override
	public Integer getCountListByTreeforChangePM(String columnSearch, String value, Integer employeeId, Integer idOldPM)  throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("employeeId", employeeId);
		map.put("idOldPM", idOldPM);
		return (Integer) mapper.queryForObject("employee.getCountListByTreeforChangePM", map);
	}

	//get count under level
	@Override
	public Integer getCountUnderLevel(Integer employeeId) throws SQLException {
		return (Integer) mapper.queryForObject("employee.getCountUnderLevel", employeeId);
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
	
	public Integer getCountByColumnEmployeeHead(String columnSearch, String value, Integer positionLevel, String paramCondition, Integer employeeId, Integer divisionId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("positionLevel", positionLevel);
		map.put("paramCondition", paramCondition);
		map.put("employeeId", employeeId);
		map.put("divisionId", divisionId);
		map.put("value", value);
		return (Integer) mapper.queryForObject("employee.getCountByColumnEmployeeHead", map);
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

	@Override
	public String getTreeIdByEmployeeId(Integer employeeId) throws SQLException {
		// TODO Auto-generated method stub
		return (String) mapper.queryForObject("employee.getTreeIdByEmployeeId", employeeId);
	}

	@Override
	public void updateTreeId(Integer length, String newTreeId,
			String oldTreeId, Integer employeeId) throws SQLException {
		// TODO Auto-generated method stub
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println(newTreeId+ " new");
			map.put("length", length);
			map.put("newTreeId", newTreeId);
			map.put("oldTreeId", oldTreeId);
			map.put("employeeId", employeeId);
			mapper.startTransaction();
			mapper.update("employee.updateTreeId", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}	
	}

	 @Override
	 public List<EmployeeBean> getListByColumnEmployeeActive(
	   String columnSearch, String value, Integer startRow, Integer endRow)
	   throws SQLException {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("columnSearch", columnSearch);
	  map.put("value", value);   
	  map.put("startRow", startRow);
	  map.put("endRow", endRow);
	  return mapper.queryForList("employee.getListByColumnEmployeeActive", map);
	 }

	 @Override
	 public Integer getCountByColumnEmployeeActive(String columnSearch,
	   String value) throws SQLException {
	  Map<String, Object> map = new HashMap<String, Object>();
	  map.put("columnSearch", columnSearch);
	  map.put("value", value);
	  return (Integer) mapper.queryForObject("employee.getCountByColumnEmployeeActive", map);
	 }

	 @Override
	 public Date getEmployeeResignDate(Integer id) throws SQLException {
	  return (Date) mapper.queryForObject("employee.getEmployeeResignDate", id);
	 }
	
	@Override
	public void insertToBlob(byte[] param) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			mapper.insert("employee.insertBlob", param);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
		
	}
	
	@Override
	public Object selectBlob() throws SQLException {
		return (Object) mapper.queryForObject("employee.selectBlob", null);
	}

	@Override
	public void updateChangePic(Integer id, byte[] filePic) throws SQLException {
		// TODO Auto-generated method stub
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println(id+ " id");
			System.out.println(filePic+ " filePic");
			System.out.println("ID = " + id);
			map.put("id", id);
			map.put("filePic", filePic);
			mapper.startTransaction();
			mapper.update("employee.updateChangePic", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}	
	}

	@Override
	public Integer getValidateDayOff(Date startDate, Date endDate, Integer empId)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);			
		map.put("empId", empId);
		return (Integer) mapper.queryForObject("employee.getValidateDayOff", map);
	}

	@Override
	public Integer getValidateWeekEnd(String startFrom, Integer empId)
			throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("empId"+empId+"empId");
		System.out.println("startFrom"+startFrom+"startFrom");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startFrom", startFrom);
		map.put("empId", empId);
		return (Integer) mapper.queryForObject("employee.getValidateWeekEnd", map);
	}
	
	public Integer getCountListProjectActive(Integer employeeId)
			throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("employee.getCountListProjectActive", employeeId);
	}
}

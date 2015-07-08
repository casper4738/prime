package prime.admin.employee;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import prime.admin.employee.EmployeeBean;

public interface EmployeeManager {
	public void insert(EmployeeBean e) throws SQLException;
	
	public void insertResign(EmployeeBean e) throws SQLException;
	
	public void insertWeekend(EmployeeBean e) throws SQLException;
	
	public void insertDayoff(EmployeeBean e) throws SQLException;
	
	public void update(EmployeeBean e) throws SQLException;
	
	/*public void updateWeekend(EmployeeBean e) throws SQLException;*/
	
	public void updatePositionDivision(EmployeeBean e) throws SQLException;
	
	public void updateStatusUser(Integer employeeId) throws SQLException;
	
	public void updateHead(Integer forCondition, Integer newHead) throws SQLException;
	
	public void updateChangePic(Integer id, byte[] filePic) throws SQLException;
	
	public void updateTreeId(Integer length, String newTreeId, String oldTreeId, Integer employeeId) throws SQLException;
	
	public void delete(Integer id) throws SQLException;
	
	public void deleteDayOff(Integer id, String startDate) throws SQLException;
	
	public void deleteWeekEnd(Integer id, String startFrom) throws SQLException;
	
	public EmployeeBean getEmployeeById(Integer id) throws SQLException;
	
	public List<EmployeeBean> getListWeekendByEmployeeId(Integer id) throws SQLException;
	
	public EmployeeBean getEmployeeWeekendByIdAndStartFrom(Integer id, String startFrom) throws SQLException;
	
	public List<EmployeeBean> getListDayoffByEmployeeId(Integer id) throws SQLException;
	
	public List<EmployeeBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<EmployeeBean> getListEmployeeHead(String columnSearch, String value,  Integer positionLevel, Integer startRow, Integer endRow, String paramCondition, Integer employeeId, Integer divisionId)
			throws SQLException;
	
	public Integer getCountByColumnEmployeeHead(String columnSearch, String value, Integer positionLevel, String paramCondition, Integer employeeId, Integer divisionId) throws SQLException;
	
	public Integer getCountByColumnEmployeeActive(String columnSearch, String value) throws SQLException;
	
	public Integer getValidateDayOff(Date startDate, Date endDate, Integer empId) throws SQLException;
	
	public Integer getValidateWeekEnd(String startFrom, Integer empId) throws SQLException;
	 
	public List<EmployeeBean> getListByColumnEmployeeActive(String columnSearch, String value, Integer startRow, Integer endRow)
	   throws SQLException;
	 
	public Date getEmployeeResignDate(Integer id) throws SQLException;
		
	/*select employee by tree */
	public List<EmployeeBean> getListByTree(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) throws SQLException;
	public Integer getCountListByTree(String columnSearch, String value, Integer employeeId)  throws SQLException;
	/* end of select employee by tree */
	
	
	//select employee tree member
	
	public List<EmployeeBean> getListTreeforMember(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId, Integer projectId) throws SQLException;
	
	public Integer getCountListByTreeforMember (String columnSearch, String value, Integer employeeId, Integer projectId)  throws SQLException;
	//end employee tree member
	
	public List<EmployeeBean> getListTreeforChangePM(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId, Integer idOldPM) throws SQLException;
	
	public Integer getCountListByTreeforChangePM(String columnSearch, String value, Integer employeeId, Integer idOldPM)  throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;

	public Integer getNewId() throws SQLException;
	
	public String getTreeIdByEmployeeId(Integer employeeId) throws SQLException;
	
	public void insertToBlob(byte[] param) throws SQLException;
	
	public Object selectBlob() throws SQLException;
	
	//Count Under Level
	public Integer getCountUnderLevel(Integer employeeId) throws SQLException;
	
	//Validate If Resign Employee Has Active as PM or Project Assigner
	public Integer getCountListProjectActive(Integer employeeId) throws SQLException;
}  

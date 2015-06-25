package prime.user.project;

import java.sql.SQLException;
import java.util.List;

import prime.admin.employee.EmployeeBean;



public interface ProjectManager {
	
	public void insert (ProjectBean e) throws SQLException;
	
	public void insertDetail(ProjectBean e) throws SQLException;
	
	public void insertMember(ProjectBean e) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public Integer getNewMemberId() throws SQLException;
	
	public Integer getCountByColumnEmployeeAll (String columnSearch, String value) throws SQLException;
	
	public ProjectBean getProjectById(Integer id) throws SQLException;
	
	public ProjectBean getDataProjectMemberByProjectMemberId(Integer projectMemberId) throws SQLException;
	
	public ProjectBean getProjectMemberDetailById(Integer id) throws SQLException;
	
	public List<ProjectBean> getListRoles (Integer employeeId, Integer projectId) throws SQLException;
	
	public List<ProjectBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException;
	
	public List<ProjectBean> getListProjectMember(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId)
			throws SQLException;
	
	public List<ProjectBean> getListProjectMemberDetails(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId)
			throws SQLException;

	public Integer getProjectMemberIdByAll(ProjectBean e) throws SQLException;
	

}

package prime.user.project;

import java.sql.SQLException;
import java.util.List;

import prime.user.task.TaskBean;

public interface ProjectManager {
	
	public void updateActualStart(Integer projectId, java.sql.Date actualStart) throws SQLException;

	public void updateActualEnd(Integer projectId, java.sql.Date actualEnd) throws SQLException;

	public void updateMainDays(Integer projectId, Integer mainDays) throws SQLException;
	
	public void insert (ProjectBean e) throws SQLException;
	
	public void insertDetail(ProjectBean e) throws SQLException;
	
	public void insertMember(ProjectBean e) throws SQLException;
	
	public void updateStatusProjectMemberRole(Integer projectMemberId, Integer projectMemberStatus) throws SQLException;
	 
	public void updateProjectReceiver(Integer projectId, Integer projectReceiver) throws SQLException;
	
	public Integer getCountListMember (Integer projectId) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getCountListByColAsHead(String columnSearch, String value, Integer employeeId) 	throws SQLException;
	
	public Integer getCountListByColAsMember(String columnSearch, String value, Integer employeeId) 	throws SQLException;
	
	public Integer getCountListTaskMember (Integer taskReceiver, Integer projectId) throws SQLException;
	
	public Integer getIdProjectAssigner (Integer employeeId, Integer projectId) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public Integer getNewMemberId() throws SQLException;
	
	public ProjectBean getProjectByTaskId(Integer id) throws SQLException;
	
	public Integer getStatusRoleMember(Integer projectMemberId, Integer roleId, Integer projectMemberStatus) throws SQLException;
	
	public Integer getCountByColumnEmployeeAll (String columnSearch, String value) throws SQLException;
	
	public Integer getProjectMemberIDbyRole (Integer projectMemberId, Integer projectReceiver, Integer employeeReceiver) throws SQLException;
	
	public Double getPercentStatusProject (Integer projectId) throws SQLException;
	
	public Integer getProjectMemberIdByAll(ProjectBean e) throws SQLException;
	
	public Integer getCountProjectAssigner(Integer projectAssigner) throws SQLException;
	
	public Integer getCountProjectReceiver(Integer projectReceiver) throws SQLException;
	
	public Integer getCountProjectMember(Integer projectMember) throws SQLException;
	
	public Integer getRoleIdbyEmployeeLoginAndProjectId(Integer employeeId, Integer projectId) throws SQLException;
	
	public ProjectBean getProjectById(Integer id) throws SQLException;
	
	public ProjectBean getDataProjectMemberByProjectMemberId(Integer projectMemberId) throws SQLException;
	
	public ProjectBean getProjectMemberDetailById(Integer id) throws SQLException;
	
	public List<ProjectBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException;
	
	public List<ProjectBean> getListByColumnAsMember(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer employeeId) throws SQLException;
	
	public List<ProjectBean> getListByColumnAsHead(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer employeeId) throws SQLException;
	
	public List<ProjectBean> getListProjectMember(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId)
			throws SQLException;
	
	public List<ProjectBean> getListProjectMemberDetails(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId, Integer projectId)
			throws SQLException;
	
	public List<ProjectBean> getProjectNamebyProjectId(Integer projectId) throws SQLException;

	
	public List<RoleOption> getRoleByProjectMember(Integer employeeId, Integer projectId) throws SQLException;
	
	public List<Integer>  getListEmployeeIDInProject(Integer projectId) throws SQLException;
	public List<TaskBean> getProjectTaskListPerMember(Integer projectId, Integer employeeId) throws SQLException;
}

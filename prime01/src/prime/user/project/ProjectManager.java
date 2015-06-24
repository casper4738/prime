package prime.user.project;

import java.sql.SQLException;
import java.util.List;

import prime.user.activity.ActivityBean;
import prime.user.task.TaskBean;



public interface ProjectManager {
	
	public List<ProjectBean> getListByColumn(String columnSearch, String value,
			Integer startRow, Integer endRow) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException;
	
	public ProjectBean getProjectById(Integer id) throws SQLException;
	
	public List<ProjectBean> getListProjectMember(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId)
			throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public void insert (ProjectBean e) throws SQLException;
	
	public void insertDetail(ProjectBean e) throws SQLException;
	
	public ProjectBean getProjectMemberDetailById(Integer id) throws SQLException;
	
	public List<ProjectBean> getListProjectMemberDetails(String columnSearch, String value, Integer startRow, Integer endRow, Integer taskId)
			throws SQLException;
	
	public List<ProjectBean> getListRoles (Integer employeeId, Integer projectId) 
			throws SQLException;
}

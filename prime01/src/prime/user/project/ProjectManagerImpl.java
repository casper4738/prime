package prime.user.project;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.employee.EmployeeBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ProjectManagerImpl implements ProjectManager {
	private SqlMapClient mapper;

	public ProjectManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	@Override
	public List<ProjectBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("project.getListByColumn", map);
	}

	@Override
	public List<ProjectBean> getListProjectMemberDetails(String columnSearch, String value, Integer startRow, Integer endRow, Integer employeeId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		return mapper.queryForList("project.getListProjectMemberDetails", map);
	}
	
	@Override
	public List<ProjectBean> getListProjectMember(String columnSearch, String value, Integer startRow, Integer endRow, Integer projectId)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("projectId", projectId);
		return mapper.queryForList("project.getListProjectMember", map);
	}
	
	@Override
	public List<ProjectBean> getListRoles(Integer employeeId, Integer projectId)
			throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return mapper.queryForList("project.getProjectRoles", map);
	}
	
	@Override
	public Integer getNewId() throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("project.getNewId", null);
	}
	
	@Override
	public Integer getNewMemberId() throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("project.getNewMemberId", null);
	}

	@Override
	public Integer getCountByColumn(String columnSearch, String value) 	throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("project.getCountListByCol", map);
	}


	@Override
	public Integer getCountByColumnEmployeeAll(String columnSearch, String value) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("project.getCountListByCol", map);
	}

	@Override
	public ProjectBean getProjectById(Integer id) throws SQLException {
		// TODO Auto-generated method stub
		return (ProjectBean) mapper.queryForObject("project.get", id);
	}

	@Override
	public ProjectBean getDataProjectMemberByProjectMemberId(Integer projectMemberId) throws SQLException {
		return (ProjectBean) mapper.queryForObject("project.getDataProjectMemberByProjectMemberId",projectMemberId);
	}

	@Override
	public ProjectBean getProjectMemberDetailById(Integer id) throws SQLException {
		return (ProjectBean) mapper.queryForObject("project.getDataEmployee", id);
	}
	
	@Override
	public void insert(ProjectBean e) throws SQLException {
		// TODO Auto-generated method stub
		System.out.println("masuk insert");
		try {
			mapper.startTransaction();
			mapper.insert("project.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	@Override
	public void insertDetail(ProjectBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("project.insertDetail", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	
	
	@Override
	public void insertMember(ProjectBean e) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			mapper.insert("project.insertMember", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	@Override
	public Integer getProjectMemberIdByAll(ProjectBean e) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectId", e.getProjectId());
		map.put("roleId", e.getRoleBean().getRoleId());
		map.put("employeeId", e.getEmployeeId());
		return (Integer) mapper.queryForObject("project.getProjectMemberIdByAll", map);
	}


}

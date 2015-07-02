package prime.user.project;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("project.getListByColumn", map);
	}

	@Override
	public List<ProjectBean> getListByColumnAsMember(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer employeeId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		map.put("employeeId", employeeId);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("project.getListByColumnAsMember", map);
	}
	
	
	
	@Override
	public List<ProjectBean> getListByColumnAsHead(String columnSearch,
			String value, Integer startRow, Integer endRow, Integer employeeId)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		map.put("employeeId", employeeId);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("project.getListByColumnAsHead", map);
	}

	@Override
	public List<ProjectBean> getListProjectMemberDetails(String columnSearch, String value, Integer startRow, 
			Integer endRow, Integer employeeId, Integer projectId) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return mapper.queryForList("project.getListProjectMemberDetails", map);
	}
	
	@Override
	public List<ProjectBean> getListProjectMember(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer projectId)
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
	public List<RoleOption> getRoleByProjectMember(Integer employeeId, Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return mapper.queryForList("project.getRoleByProjectMember", map);
	}
	
	
	
	@Override
	public List<ProjectBean> getProjectNamebyProjectId(Integer projectId) throws SQLException {
		 
		return mapper.queryForList("project.getProjectNamebyProjectId", projectId);
	}

	@Override
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("project.getNewId", null);
	}
	
	@Override
	public Integer getNewMemberId() throws SQLException {
		return (Integer) mapper.queryForObject("project.getNewMemberId", null);
	}

	@Override
	public Integer getCountByColumn(String columnSearch, String value) 	throws SQLException {
		 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("project.getCountListByCol", map);
	}

	@Override
	public Integer getCountListByColAsHead(String columnSearch, String value, Integer employeeId) 	throws SQLException {
		 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("employeeId", employeeId);
		return (Integer) mapper.queryForObject("project.getCountListByColAsHead", map);
	}
	

	@Override
	public Integer getCountByColumnEmployeeAll(String columnSearch, String value) throws SQLException {
		 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("project.getCountListByCol", map);
	}

	
	
	@Override
	public Double getPercentStatusProject(Integer projectId)
			throws SQLException {
		 
		return (Double) mapper.queryForObject("project.getPercentStatusProject", projectId);
	}

	
	
	@Override
	public Integer getCountProjectAssigner(Integer projectAssigner) throws SQLException {
		return (Integer) mapper.queryForObject("project.getCountProjectAssigner", projectAssigner);
	}

	@Override
	public Integer getCountProjectReceiver(Integer projectReceiver) throws SQLException {
		return (Integer) mapper.queryForObject("project.getCountProjectReceiver", projectReceiver);
	}

	
	@Override
	public Integer getCountProjectMember(Integer projectMember) throws SQLException {
		return (Integer) mapper.queryForObject("project.getCountProjectMember", projectMember);
	}

	
	
	@Override
	public Integer getRoleIdbyEmployeeLoginAndProjectId(Integer employeeId,Integer projectId) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("employeeId", employeeId);
		map.put("projectId", projectId);
		return (Integer) mapper.queryForObject("project.getRoleIdbyEmployeeLoginAndProjectId", map);
	}

	@Override
	public ProjectBean getProjectById(Integer id) throws SQLException {
		 
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
	public void updateStatusProjectMemberRole(Integer projectMemberId, Integer projectMemberStatus) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectMemberId", projectMemberId);
			map.put("projectMemberStatus", projectMemberStatus);
			mapper.startTransaction();
			mapper.update("project.updateStatusProjectMemberRole", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	
	
	@Override
	public void updateProjectReceiver(Integer projectId, Integer projectReceiver)
			throws SQLException {
		 
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("projectId", projectId);
			map.put("projectReceiver", projectReceiver);
			mapper.startTransaction();
			mapper.update("project.updateProjectReceiver", map);
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

	@Override
	public Integer getStatusRoleMember(Integer projectMemberId, Integer roleId,
			Integer projectMemberStatus) throws SQLException {
		 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectMemberId", projectMemberId);
		map.put("roleId", roleId);
		map.put("projectMemberStatus", projectMemberStatus);
		return (Integer) mapper.queryForObject("project.getStatusRoleMember", map);
	}

	@Override
	public Integer getProjectMemberIDbyRole(Integer projectId,
			Integer projectReceiver, Integer employeeReceiver) throws SQLException {
		 
		System.out.println("masuk "+projectId +"-"+ projectReceiver );
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projectId", projectId);
		map.put("projectReceiver", projectReceiver);
		map.put("employeeReceiver", employeeReceiver);
		
		return (Integer) mapper.queryForObject("project.getProjectMemberIDbyRole", map);
	}

	

}

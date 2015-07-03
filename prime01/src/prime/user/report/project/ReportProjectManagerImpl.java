package prime.user.report.project;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.user.project.ProjectBean;
import prime.user.report.employees.ReportEmployeesBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ReportProjectManagerImpl implements ReportProjectManager {

	private SqlMapClient mapper;

	public ReportProjectManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public List<ReportProjectBean> getListByColumn(String columnSearch,
			String value, Integer startRow, Integer endRow) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("reportproject.getListByColumn", map);
	}

	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch + "");
		if("STARTDATE".equals(columnSearch) || "ESTIMATEDATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startDate", string[0]);
			map.put("untilDate", string[1]);
		} else {
			map.put("value", value);
		}
		return (Integer) mapper.queryForObject(
				"reportproject.getCountListByCol", map);
	}

	public ReportProjectBean getProjectById(Integer id) throws SQLException {
		return (ReportProjectBean) mapper.queryForObject("reportproject.get",
				id);
	}
	
	
	public Integer getCountListByColAsHead(String columnSearch, String value, Integer employeeId) 	throws SQLException {
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
		return (Integer) mapper.queryForObject("project.getCountListByColAsHead", map);
	}
	
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
}

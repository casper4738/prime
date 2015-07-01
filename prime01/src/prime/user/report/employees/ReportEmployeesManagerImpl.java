package prime.user.report.employees;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.employee.EmployeeBean;
import prime.constants.Constants;
import prime.user.task.TaskBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class ReportEmployeesManagerImpl implements ReportEmployeesManager{

	private SqlMapClient mapper;
	
	public ReportEmployeesManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}
	
	public List<ReportEmployeesBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("reportemployees.getListByColumn", map);
	}
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch+"");
		map.put("value", value+"");
		return  (Integer) mapper.queryForObject("reportemployees.getCountByColumn", map);
	}
	
	public ReportEmployeesBean getEmployeeById(Integer id) throws SQLException {
		return (ReportEmployeesBean) mapper.queryForObject("reportemployees.get", id);
	}
	
	public List<TaskBean> getListByColumnSubordinate(String columnSearch, String value, Integer startRow, Integer endRow, 
			Integer taskReceiver) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("taskReceiver", taskReceiver);
		map.put("finish", Constants.Status.FINISH);
		map.put("abort", Constants.Status.ABORT);
		return mapper.queryForList("reportemployees.getListByColumnSubordinate", map);
	}
}

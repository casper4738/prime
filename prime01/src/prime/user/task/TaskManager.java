package prime.user.task;

import java.sql.SQLException;
import java.util.List;

import prime.user.project.ProjectBean;

public interface TaskManager {

	public void insert(TaskBean e) throws SQLException;
	
	public void insertDetail(TaskBean e) throws SQLException;
	
	public void insertDetailBySelectTask(TaskBean e) throws SQLException;

	public TaskBean getTaskById(Integer id) throws SQLException;

	public Integer getNewId() throws SQLException;
	
	public Boolean isCheckStatus(Integer taskId, Integer status) throws SQLException;
	
	public Boolean isCheckStatusDetail(Integer taskId, Integer status) throws SQLException;

	/*Task Head*/
	public List<TaskBean> getListByColumnHead(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer taskAssigner) throws SQLException;

	public Integer getCountByColumnHead(String columnSearch, String value, Integer taskAssigner) throws SQLException;
	/*End Task Head*/
	
	/*Task Subordinate*/
	public List<TaskBean> getListByColumnSubordinate(String columnSearch, String value, Integer startRow, Integer endRow,
			Integer taskReceiver) throws SQLException;

	public Integer getCountByColumnSubordinate(String columnSearch, String value, Integer taskReceiver) throws SQLException;
	/*End Task Subordinate*/
}

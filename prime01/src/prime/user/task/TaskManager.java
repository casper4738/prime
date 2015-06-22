package prime.user.task;

import java.sql.SQLException;
import java.util.List;

public interface TaskManager {

	public void insert(TaskBean e) throws SQLException;
	
	public void insertDetail(TaskBean e) throws SQLException;

	public TaskBean getTaskById(Integer id) throws SQLException;

	public List<TaskBean> getListByColumn(String columnSearch, String value,
			Integer startRow, Integer endRow) throws SQLException;

	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException;

	public Integer getNewId() throws SQLException;
}

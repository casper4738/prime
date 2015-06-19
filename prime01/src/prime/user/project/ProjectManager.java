package prime.user.project;

import java.sql.SQLException;
import java.util.List;



public interface ProjectManager {
	
	public List<ProjectBean> getListByColumn(String columnSearch, String value,
			Integer startRow, Integer endRow) throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value)
			throws SQLException;
}

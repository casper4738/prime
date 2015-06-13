package prime.admin.position;

import java.sql.SQLException;
import java.util.List;

public interface PositionManager {

	public void insert(PositionBean e) throws SQLException;
	
	public void update(PositionBean e) throws SQLException;
	
	public void delete(Integer id) throws SQLException;
	
	public PositionBean getPositionById(Integer id) throws SQLException;
	
	public List<PositionBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
}

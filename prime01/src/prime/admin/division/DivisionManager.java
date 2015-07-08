package prime.admin.division;

import java.sql.SQLException;
import java.util.List;

public interface DivisionManager {

	public void insert(DivisionBean e) throws SQLException;
	
	public void update(DivisionBean e) throws SQLException;
	
	public void delete(Integer id) throws SQLException;
	
	public DivisionBean getDivisionById(Integer id) throws SQLException;
	
	public List<DivisionBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public List<DivisionBean> getListAll() throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
	public Integer getDivisionUsed(Integer divisionId) throws SQLException;
}

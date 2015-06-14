package prime.admin.holiday;

import java.sql.SQLException;
import java.util.List;

public interface HolidayManager {

	public void insert(HolidayBean e) throws SQLException;
	
	public void update(HolidayBean e) throws SQLException;
	
	public void delete(java.sql.Date date) throws SQLException;
	
	public HolidayBean getHolidayById(java.sql.Date date) throws SQLException;
	
	public List<HolidayBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow)
			throws SQLException;
	
	public Integer getCountByColumn(String columnSearch, String value) throws SQLException;
	
	public Integer getNewId() throws SQLException;
	
}

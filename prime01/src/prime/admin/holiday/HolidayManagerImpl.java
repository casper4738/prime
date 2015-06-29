package prime.admin.holiday;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class HolidayManagerImpl implements HolidayManager {

	private SqlMapClient mapper;
	
	public HolidayManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(HolidayBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("holiday.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(HolidayBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("holiday.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(java.sql.Date date) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.delete("holiday.delete", date);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public HolidayBean getHolidayById(java.sql.Date date) throws SQLException {
		return (HolidayBean) mapper.queryForObject("holiday.get", date);
	}

	public List<HolidayBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		if("DATE".equals(columnSearch)) {
			String[] string = value.split(";");
			map.put("startHoliday", string[0]);
			map.put("untilHoliday", string[1]);
			
			System.out.println("1."+string[0]);
			System.out.println("2."+string[1]);
		} else {
			map.put("value", value);
		}
		map.put("columnSearch", columnSearch);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("holiday.getListByCol", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("holiday.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("holiday.getCountListByCol", map);
	}
	
	public Integer getYear (Integer year) throws SQLException {
		return (Integer) mapper.queryForObject("holiday.getYear", null);
	}

	@Override
	public List<HolidayBean> getListByYear(Integer paramYear) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramYear", paramYear+"");
		return mapper.queryForList("holiday.getListByYear", map);
	}

}

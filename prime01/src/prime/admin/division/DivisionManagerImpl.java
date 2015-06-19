package prime.admin.division;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class DivisionManagerImpl implements DivisionManager {

	private SqlMapClient mapper;
	
	public DivisionManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(DivisionBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("division.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(DivisionBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("division.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(Integer id) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.delete("division.delete", id);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public DivisionBean getDivisionById(Integer id) throws SQLException {
		return (DivisionBean) mapper.queryForObject("division.get", id);
	}

	public List<DivisionBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("division.getListByCol", map);
	}
	

	public List<DivisionBean> getListAll() throws SQLException {
		return mapper.queryForList("division.selectAll", null);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("division.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("division.getCountListByCol", map);
	}

}

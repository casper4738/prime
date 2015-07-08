package prime.admin.position;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.division.DivisionBean;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class PositionManagerImpl implements PositionManager {

	private SqlMapClient mapper;
	
	public PositionManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(PositionBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.insert("position.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(PositionBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("position.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(Integer id) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.delete("position.delete", id);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public PositionBean getPositionById(Integer id) throws SQLException {
		return (PositionBean) mapper.queryForObject("position.get", id);
	}

	public List<PositionBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return mapper.queryForList("position.getListByCol", map);
	}
	
	public List<PositionBean> getListAll() throws SQLException {
		return mapper.queryForList("position.selectAll", null);
	}
	
	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("position.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("position.getCountListByCol", map);
	}

	@Override
	public Integer getPositionUsed(Integer positionId) throws SQLException {
		// TODO Auto-generated method stub
		return (Integer) mapper.queryForObject("position.getPositionUsed", positionId);
	}
}

package prime.admin.user;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import prime.admin.setting.GeneralSettingManager;
import prime.admin.setting.GeneralSettingManagerImpl;
import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class UserManagerImpl implements UserManager {
	private SqlMapClient mapper;
	
	public UserManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void insert(UserBean e) throws SQLException {
		try {
			//We use username as salt because username is unique and easier to be added
			GeneralSettingManager tmpGeneralManager = new GeneralSettingManagerImpl();
			e.setPassword(e.getPassword() + e.getUserName().toLowerCase());
			
			mapper.startTransaction();
			mapper.insert("user.insert", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void update(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.update", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public void delete(String username) throws SQLException {
		// TODO Auto-generated method stub
		try {
			mapper.startTransaction();
			mapper.delete("user.delete", username);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public UserBean getUserByUsername(String username) throws SQLException {
		return (UserBean) mapper.queryForObject("user.get", username);
	}

	public boolean isUserValidated(String username, String password){
		//##0.Temp Variable
		boolean tmpUserValidated = false;
		HashMap<String, String> tmpParam = new HashMap<String, String>();
		tmpParam.put("userName", username);
		tmpParam.put("password", password + username.toLowerCase());
		
		//##1.Ibatis Proccess
		try {
			tmpUserValidated = ((Integer)mapper.queryForObject("user.isUserValidated", tmpParam) <= 0) ? false : true;	
		} catch (Exception e){
			//TO DO :: Add Error Log, if can
			e.printStackTrace();
		}
		
		return tmpUserValidated;
		
	}
	
	public void changePassword(String username, String newPassword) throws SQLException {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("username", username);
			map.put("newPassword", newPassword + username.toLowerCase());			
			
			mapper.startTransaction();
			mapper.update("user.changePassword", map);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
		
	}
	
	public List<UserBean> getListByColumn(String columnSearch, String value, Integer startRow, Integer endRow) 
			throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);			
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return mapper.queryForList("user.getListByColumn", map);
	}

	public Integer getNewId() throws SQLException {
		return (Integer) mapper.queryForObject("user.getNewId", null);
	}

	public Integer getCountByColumn(String columnSearch, String value) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("columnSearch", columnSearch);
		map.put("value", value);
		return (Integer) mapper.queryForObject("user.getCountListByColumn", map);
	}
	

	public void resetPassword(UserBean e) throws SQLException {
		try {
			//We use username as salt because username is unique and easier to be added
			GeneralSettingManager tmpGeneralManager = new GeneralSettingManagerImpl();
			e.setPassword(tmpGeneralManager.getGeneralSetting().getResetPassword() + e.getUserName().toLowerCase());
			
			mapper.startTransaction();
			mapper.update("user.reset", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
		
	}
	
	public void lockUser(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.lock", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void unlockUser(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.unlock", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void changeActionDate(UserBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.changeActionDate", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
	
	public void resetSession(String username) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("user.resetSession", username);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}
}

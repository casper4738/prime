package prime.login;

import java.sql.SQLException;
import java.util.HashMap;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class LoginManagerImpl implements LoginManager {

	private SqlMapClient mapper;
	
	public LoginManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public boolean isUserExists(String username) throws SQLException {
		//##0.Temp Variable
		boolean tmpUserExists = false;
		
		//##1.Ibatis Proccess
		tmpUserExists = ((Integer)mapper.queryForObject("login.isUserExists", username) <= 0) ? false : true;	
		
		return tmpUserExists;
	}
	
	public boolean isUserValidated(String username, String password) throws SQLException {
		//##0.Temp Variable
		boolean tmpUserValidated = false;
		HashMap<String, String> tmpParam = new HashMap<String, String>();
		tmpParam.put("userName", username);
		tmpParam.put("password", password);
		
		//##1.Ibatis Proccess
		tmpUserValidated = ((Integer)mapper.queryForObject("login.isUserValidated", tmpParam) <= 0) ? false : true;	
		
		return tmpUserValidated;	
	}

	public LoginBean getUserDetails(String username) throws SQLException {
		//##0.Temp Variable
		LoginBean tmpBean = null;
		
		//##1.Ibatis Proccess

		return (LoginBean)mapper.queryForObject("login.getUserDetails", username);
	}
	
	public void setLoginSession(String username) throws SQLException{
		mapper.startTransaction();
		mapper.update("login.setLoginSession", username);
		mapper.commitTransaction();	
	}
	
	public String getLoginSession(String username) throws SQLException{
		//##0.Temp Variable
		String tmpBean = "";
		
		//##1.Ibatis Proccess
		tmpBean = (String)mapper.queryForObject("login.getLoginSession", username);

		return tmpBean;
	}
}

package prime.login;

import java.util.HashMap;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class LoginManagerImpl implements LoginManager {

	private SqlMapClient mapper;
	
	public LoginManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public boolean isUserExists(String username) {
		//##0.Temp Variable
		boolean tmpUserExists = false;
		
		//##1.Ibatis Proccess
		try {
			tmpUserExists = ((Integer)mapper.queryForObject("login.isUserExists", username) <= 0) ? false : true;	
		} catch (Exception e){
			//TO DO :: Add Error Log, if can
			e.printStackTrace();
		}
		
		return tmpUserExists;
	}
	
	public boolean isUserValidated(String username, String password){
		//##0.Temp Variable
		boolean tmpUserValidated = false;
		HashMap<String, String> tmpParam = new HashMap<String, String>();
		tmpParam.put("username", username);
		tmpParam.put("password", password);
		
		//##1.Ibatis Proccess
		try {
			tmpUserValidated = ((Integer)mapper.queryForObject("login.isUserValidated", tmpParam) <= 0) ? false : true;	
		} catch (Exception e){
			//TO DO :: Add Error Log, if can
			e.printStackTrace();
		}
		
		return tmpUserValidated;
		
	}

	public LoginBean getUserDetails(String username) {
		//##0.Temp Variable
		LoginBean tmpBean = null;
		
		//##1.Ibatis Proccess
		try {
			tmpBean = (LoginBean)mapper.queryForObject("login.getUserDetails", username);
		} catch (Exception e){
			//TO DO :: Add Error Log, if can
			e.printStackTrace();
		}
		
		return tmpBean;
	}
	
}

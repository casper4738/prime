package prime.login;

import java.sql.SQLException;
import prime.admin.user.UserBean;
import prime.utility.IbatisHelper;
import com.ibatis.sqlmap.client.SqlMapClient;

public class LoginManagerImpl implements LoginManager {

	private SqlMapClient mapper;
	
	public LoginManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public UserBean getUser(String username) throws SQLException {
		return (UserBean) mapper.queryForObject("login.getUser", username);
	}
	
}

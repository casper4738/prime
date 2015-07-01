package prime.admin.setting;

import java.sql.SQLException;

public interface GeneralSettingManager {

	public void save(GeneralSettingBean e) throws SQLException;
	
	public GeneralSettingBean getGeneralSetting() throws SQLException;
	
	
}

package prime.admin.setting;

import java.sql.SQLException;

import prime.utility.IbatisHelper;

import com.ibatis.sqlmap.client.SqlMapClient;

public class GeneralSettingManagerImpl implements GeneralSettingManager {

	private SqlMapClient mapper;

	public GeneralSettingManagerImpl() {
		mapper = IbatisHelper.getSqlMapInstance();
	}

	public void save(GeneralSettingBean e) throws SQLException {
		try {
			mapper.startTransaction();
			mapper.update("generalsetting.save", e);
			mapper.commitTransaction();
		} finally {
			mapper.endTransaction();
		}
	}

	public GeneralSettingBean getGeneralSetting() throws SQLException {
		GeneralSettingBean e = (GeneralSettingBean) mapper.queryForObject("generalsetting.get", null);
		if(e == null) {
			return new GeneralSettingBean();
		} else {
			return e;
		}
	}

}

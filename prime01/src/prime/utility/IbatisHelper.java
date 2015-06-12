package prime.utility;

import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class IbatisHelper {
	
	private static final SqlMapClient mapper;
	
	static {
		try {
			String resource = "ibatis-config.xml";
			Reader reader = Resources.getResourceAsReader(resource);
			mapper = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error initializing IbatisHelper class. Cause : " + e);
		}
	}

	public static SqlMapClient getSqlMapInstance() {
		return mapper;
	}
}

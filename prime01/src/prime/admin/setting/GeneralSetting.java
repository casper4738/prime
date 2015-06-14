package prime.admin.setting;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import prime.utility.PrimeUtil;

public class GeneralSetting {
	
	private File file;	
	private String FILENAME = "/setting.xml";	
	public GeneralSetting(HttpServletRequest request) {
		File f = new File(PrimeUtil.getPath(request) + "/setting");
		file = new File(f.getAbsolutePath()+FILENAME);
		if (!file.exists()) {
			f.mkdirs();
			f.setReadable(true, false);
			f.setExecutable(true, false);
			f.setWritable(true, false);
			createSetting();
		}
	}

	public void createSetting() {
		SettingBean e = new SettingBean();
		e.setLevel(8);
		e.setTimeOut(30);
		e.setDatabaseParameter("orcl");
		e.setMinLevelApproval(1);
		save(e);
	}
	
	public void save(SettingBean e) {
		FileOutputStream outputStream = null;
		try {
			outputStream = new FileOutputStream(file);
			Properties properties = new Properties();
			properties.put("level", String.valueOf(e.getLevel()));
			properties.put("time_out", String.valueOf(e.getTimeOut()));
			properties.put("db_parameter", e.getDatabaseParameter());
			properties.put("min_level_approval", String.valueOf(e.getMinLevelApproval()));
			properties.storeToXML(outputStream, "PRIME 2015");
			System.out.println("Location File Setting : " + file.getAbsolutePath());
		} catch (Exception ex) {
			System.out.println("Terjadi kesalahan save : " + ex.getMessage());
		}  finally {
			try {
				outputStream.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}			
		}
	}
	
	public SettingBean getSetting() {
		FileInputStream inputStream = null;
		SettingBean e = new SettingBean();
		try {
			inputStream = new FileInputStream(file);
			Properties properties = new Properties();
			properties.loadFromXML(inputStream);
			e.setLevel(Integer.parseInt(properties.getProperty("level")));
			e.setTimeOut(Integer.parseInt(properties.getProperty("time_out")));
			e.setDatabaseParameter(properties.getProperty("db_parameter"));
			e.setMinLevelApproval(Integer.parseInt(properties.getProperty("min_level_approval")));
			inputStream.close();
		} catch (Exception ex) {
			System.out.println("Terjadi kesalahan get : " + ex.getMessage());
		} finally {
			try {
				inputStream.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}			
		}
		return e;
	}

}

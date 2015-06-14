package prime.admin.setting;

public class SettingBean {

	private Integer level;
	private Integer timeOut;
	private Integer minLevelApproval;
	private String databaseParameter;

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getTimeOut() {
		return timeOut;
	}

	public void setTimeOut(Integer timeOut) {
		this.timeOut = timeOut;
	}

	public Integer getMinLevelApproval() {
		return minLevelApproval;
	}

	public void setMinLevelApproval(Integer minLevelApproval) {
		this.minLevelApproval = minLevelApproval;
	}

	public String getDatabaseParameter() {
		return databaseParameter;
	}

	public void setDatabaseParameter(String databaseParameter) {
		this.databaseParameter = databaseParameter;
	}

}

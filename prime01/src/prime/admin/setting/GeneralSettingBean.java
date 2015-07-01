package prime.admin.setting;

public class GeneralSettingBean {

	private Integer generalSettingLevel = 0;
	private Integer generalSettingTimeOut = 0;
	private Integer minLevelApproval = 0;
	private String smtpUsername;
	private String smtpPassword;

	public String getSmtpUsername() {
		return smtpUsername;
	}

	public void setSmtpUsername(String smtpUsername) {
		this.smtpUsername = smtpUsername;
	}

	public String getSmtpPassword() {
		return smtpPassword;
	}

	public void setSmtpPassword(String smtpPassword) {
		this.smtpPassword = smtpPassword;
	}

	public Integer getGeneralSettingLevel() {
		return generalSettingLevel;
	}

	public void setGeneralSettingLevel(Integer generalSettingLevel) {
		this.generalSettingLevel = generalSettingLevel;
	}

	public Integer getGeneralSettingTimeOut() {
		return generalSettingTimeOut;
	}

	public void setGeneralSettingTimeOut(Integer generalSettingTimeOut) {
		this.generalSettingTimeOut = generalSettingTimeOut;
	}

	public Integer getMinLevelApproval() {
		return minLevelApproval;
	}

	public void setMinLevelApproval(Integer minLevelApproval) {
		this.minLevelApproval = minLevelApproval;
	}

}

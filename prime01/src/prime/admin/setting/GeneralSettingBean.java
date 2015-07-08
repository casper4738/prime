package prime.admin.setting;

public class GeneralSettingBean {

	private Integer generalSettingLevel = 0;
	private Integer minLevelApproval = 0;
	private String smtpUsername;
	private String smtpPassword;
	private String updateBy;
	private String usernameActiveDirectory;
	private String passwordActiveDirectory;
	private String weekend;
	private String resetPassword;

	public String getResetPassword() {
		return resetPassword;
	}

	public void setResetPassword(String resetPassword) {
		this.resetPassword = resetPassword;
	}

	public String getWeekend() {
		return weekend;
	}

	public void setWeekend(String weekend) {
		this.weekend = weekend;
	}

	public String getUsernameActiveDirectory() {
		return usernameActiveDirectory;
	}

	public void setUsernameActiveDirectory(String usernameActiveDirectory) {
		this.usernameActiveDirectory = usernameActiveDirectory;
	}

	public String getPasswordActiveDirectory() {
		return passwordActiveDirectory;
	}

	public void setPasswordActiveDirectory(String passwordActiveDirectory) {
		this.passwordActiveDirectory = passwordActiveDirectory;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

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

	public Integer getMinLevelApproval() {
		return minLevelApproval;
	}

	public void setMinLevelApproval(Integer minLevelApproval) {
		this.minLevelApproval = minLevelApproval;
	}

}

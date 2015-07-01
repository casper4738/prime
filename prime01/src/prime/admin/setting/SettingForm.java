package prime.admin.setting;

import org.apache.struts.action.ActionForm;

public class SettingForm extends ActionForm {

	private GeneralSettingBean settingBean = new GeneralSettingBean();
	private String task;
	private String message;
	private String smtpPassword;

	public String getSmtpPassword() {
		return smtpPassword;
	}

	public void setSmtpPassword(String smtpPassword) {
		this.smtpPassword = smtpPassword;
	}

	public GeneralSettingBean getSettingBean() {
		return settingBean;
	}

	public void setSettingBean(GeneralSettingBean settingBean) {
		this.settingBean = settingBean;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}

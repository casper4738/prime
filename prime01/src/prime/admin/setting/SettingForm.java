package prime.admin.setting;

import org.apache.struts.action.ActionForm;

public class SettingForm extends ActionForm {

	private SettingBean settingBean = new SettingBean();
	private String task;
	private String message;

	public SettingBean getSettingBean() {
		return settingBean;
	}

	public void setSettingBean(SettingBean settingBean) {
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

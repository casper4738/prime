package prime.admin.setting;

import org.apache.struts.action.ActionForm;

public class SettingForm extends ActionForm {

	private GeneralSettingBean settingBean = new GeneralSettingBean();
	private String task;
	private String message;
	private String weekends;

	public String getWeekends() {
		return weekends;
	}

	public void setWeekends(String weekends) {
		this.weekends = weekends;
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

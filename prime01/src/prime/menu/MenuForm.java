package prime.menu;

import org.apache.struts.action.ActionForm;

public class MenuForm extends ActionForm {
	//##0.Main Variable
	private String task;
	
	//##1.Public Method
	public String getTask() {
		return task;
	}
	public void setTask(String task) {
		this.task = task;
	}
	
}

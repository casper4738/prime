package prime.modal;

import org.apache.struts.action.ActionForm;

public class ModalForm extends ActionForm {
	private String  task;
	
	private String param1;
	private String param2;
	private String param3;
	
	private String search = "";
	private String  columnSearch = "";
	private Integer goToPage   	= 1;
	private Integer showInPage 	= 10;

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getColumnSearch() {
		return columnSearch;
	}

	public void setColumnSearch(String columnSearch) {
		this.columnSearch = columnSearch;
	}

	public Integer getGoToPage() {
		return goToPage;
	}

	public void setGoToPage(Integer goToPage) {
		this.goToPage = goToPage;
	}

	public Integer getShowInPage() {
		return showInPage;
	}

	public void setShowInPage(Integer showInPage) {
		this.showInPage = showInPage;
	}

	public String getParam3() {
		return param3;
	}

	public void setParam3(String param3) {
		this.param3 = param3;
	}

	public String getParam2() {
		return param2;
	}

	public void setParam2(String param2) {
		this.param2 = param2;
	}

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}

}

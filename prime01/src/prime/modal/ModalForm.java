package prime.modal;

import org.apache.struts.action.ActionForm;

public class ModalForm extends ActionForm {
	private String  task;
	
	private String param1;
	private Integer param2;
	private String param3;
	private Integer param4;
	private Integer param5;
	
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

	public Integer getParam2() {
		return param2;
	}

	public void setParam2(Integer param2) {
		this.param2 = param2;
	}

	public String getParam1() {
		return param1;
	}

	public void setParam1(String param1) {
		this.param1 = param1;
	}

	public Integer getParam4() {
		return param4;
	}

	public void setParam4(Integer param4) {
		this.param4 = param4;
	}

	public Integer getParam5() {
		return param5;
	}

	public void setParam5(Integer param5) {
		this.param5 = param5;
	}

}

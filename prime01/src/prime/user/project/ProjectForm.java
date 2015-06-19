package prime.user.project;

import org.apache.struts.action.ActionForm;

public class ProjectForm extends ActionForm {
	private ProjectBean projectBean  = new ProjectBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer radioChoose;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;

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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Integer getRadioChoose() {
		return radioChoose;
	}

	public void setRadioChoose(Integer radioChoose) {
		this.radioChoose = radioChoose;
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

	public Integer getTmpId() {
		return tmpId;
	}

	public void setTmpId(Integer tmpId) {
		this.tmpId = tmpId;
	}

	public ProjectBean getProjectBean() {
		return projectBean;
	}

	public void setProjectBean(ProjectBean projectBean) {
		this.projectBean = projectBean;
	}
	
}

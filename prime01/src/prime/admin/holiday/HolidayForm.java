package prime.admin.holiday;

import java.sql.Date;

import org.apache.struts.action.ActionForm;

public class HolidayForm extends ActionForm {

	private HolidayBean holidayBean = new HolidayBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Date tmpId = new Date(new java.util.Date().getTime());

	public HolidayBean getHolidayBean() {
		return holidayBean;
	}

	public void setHolidayBean(HolidayBean holidayBean) {
		this.holidayBean = holidayBean;
	}

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

	public Date getTmpId() {
		return tmpId;
	}

	public void setTmpId(Date tmpId) {
		this.tmpId = tmpId;
	}

}
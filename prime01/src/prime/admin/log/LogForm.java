package prime.admin.log;

import java.sql.Date;

import org.apache.struts.action.ActionForm;

public class LogForm extends ActionForm {
	private LogBean logBean = new LogBean();
	private String task;
	private String search;
	private String columnSearch;
	private String searchTableLog;
	private String message;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private java.sql.Date startHoliday;
	private java.sql.Date untilHoliday;
	private Boolean isShowAll = true;

	public LogForm() {
		setStartHoliday(new Date(new java.util.Date().getTime()));
		setUntilHoliday(new Date(new java.util.Date().getTime()));
	}

	public Boolean getIsShowAll() {
		return isShowAll;
	}

	public void setIsShowAll(Boolean isShowAll) {
		this.isShowAll = isShowAll;
	}

	public String getColumnSearchReal() {
		if (isShowAll) {
			return "SHOW ALL";
		} else {
			return columnSearch;
		}
	}

	public String getSearchTableLog() {
		return searchTableLog;
	}

	public void setSearchTableLog(String searchTableLog) {
		this.searchTableLog = searchTableLog;
	}

	public java.sql.Date getStartHoliday() {
		return startHoliday;
	}

	public void setStartHoliday(java.sql.Date startHoliday) {
		this.startHoliday = startHoliday;
	}

	public java.sql.Date getUntilHoliday() {
		return untilHoliday;
	}

	public void setUntilHoliday(java.sql.Date untilHoliday) {
		this.untilHoliday = untilHoliday;
	}

	public LogBean getLogBean() {
		return logBean;
	}

	public void setLogBean(LogBean logBean) {
		this.logBean = logBean;
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

	public Integer getTmpId() {
		return tmpId;
	}

	public void setTmpId(Integer tmpId) {
		this.tmpId = tmpId;
	}

}

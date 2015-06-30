package prime.admin.employee;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

public class EmployeeForm extends ActionForm {

	private EmployeeBean employeeBean = new EmployeeBean();
	private String task;
	private String search;
	private String columnSearch;
	private String message;
	private Integer managerId = 0;
	private Integer substituteHeadId = 0;
	private Integer employeeId = 0;
	private Integer goToPage = 1;
	private Integer showInPage = 10;
	private Integer tmpId;
	private String tmpString;
	private String result;
	private Integer divisionId;
	private String listMondayDate;
	private String weekEnd;
	private String weekEnds;
	private Object path;
	private FormFile profpic;
	
	public EmployeeBean getEmployeeBean() {
		return employeeBean;
	}
	public void setEmployeeBean(EmployeeBean employeeBean) {
		this.employeeBean = employeeBean;
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
	public Integer getManagerId() {
		return managerId;
	}
	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
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
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Integer getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}
	public String getListMondayDate() {
		return listMondayDate;
	}
	public void setMondayDate(String listMondayDate) {
		this.listMondayDate = listMondayDate;
	}
	public String getWeekEnd() {
		return weekEnd;
	}
	public void setWeekEnd(String weekEnd) {
		this.weekEnd = weekEnd;
	}
	public String getWeekEnds() {
		return weekEnds;
	}
	public void setWeekEnds(String weekEnds) {
		this.weekEnds = weekEnds;
	}
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public Integer getSubstituteHeadId() {
		return substituteHeadId;
	}
	public void setSubstituteHeadId(Integer substituteHeadId) {
		this.substituteHeadId = substituteHeadId;
	}
	public String getTmpString() {
		return tmpString;
	}
	public void setTmpString(String tmpString) {
		this.tmpString = tmpString;
	}
	public Object getPath() {
		return path;
	}
	public void setPath(Object path) {
		this.path = path;
	}
	public FormFile getProfpic() {
		return profpic;
	}
	public void setProfpic(FormFile profpic) {
		this.profpic = profpic;
	}
}

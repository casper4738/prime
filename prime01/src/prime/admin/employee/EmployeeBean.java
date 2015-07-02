package prime.admin.employee;

import java.sql.Date;

import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.tomcat.util.codec.binary.StringUtils;

import prime.admin.holiday.HolidayBean;

public class EmployeeBean {//extends HolidayBean 
	private Integer employeeId;
	private Integer gender = 0;
	private Integer divisionId = 0;
	private Integer managerDivisionId = 0;
	private Integer positionId = 0;
	private Integer managerId = 0;
	private Integer totalDay = 1;
	private String contactNumber;
	private String employeeName;
	private String address;
	private String email;
	private String divisionName;
	private String positionName;
	private String managerName;
	private String employeeStatus;
	private String resignNote;
	private Date birthdate;
	private Date resignDate;
	private Date hireDate;
	private Date startDate;
	private Date endDate;
	private Date startFrom;
	private Date maxStartFrom;
	private String descriptionDayOff;
	private String descriptionWeekEnd;
	private String weekEnd;
	private String monthYear;
	private Date mondayDate;
	private byte[] filePic;
	private String substituteHead;
	private String treeId;
	private String filePicConverted;
	private String startMondayDate;
		
	public EmployeeBean() {
		setHireDate(new java.sql.Date(new java.util.Date().getTime()));
		setBirthdate(new java.sql.Date(new java.util.Date().getTime()));
		setResignDate(new java.sql.Date(new java.util.Date().getTime()));
		setStartDate(new java.sql.Date(new java.util.Date().getTime()));
		setEndDate(new java.sql.Date(new java.util.Date().getTime()));
		setStartFrom(new java.sql.Date(new java.util.Date().getTime()));
	}
	
	public Integer getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public Integer getDivisionId() {
		return divisionId;
	}
	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	
	public Integer getManagerId() {
		return managerId;
	}
	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDivisionName() {
		return divisionName;
	}
	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getEmployeeStatus() {
		return employeeStatus;
	}
	public void setEmployeeStatus(String employeeStatus) {
		this.employeeStatus = employeeStatus;
	}
	public String getResignNote() {
		return resignNote;
	}
	public void setResignNote(String resignNote) {
		this.resignNote = resignNote;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}
	public Date getResignDate() {
		return resignDate;
	}
	public void setResignDate(Date resignDate) {
		this.resignDate = resignDate;
	}
	public Date getHireDate() {
		return hireDate;
	}
	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getTotalDay() {
		return totalDay;
	}
	public void setTotalDay(Integer totalDay) {
		this.totalDay = totalDay;
	}
	public String getDescriptionDayOff() {
		return descriptionDayOff;
	}
	public void setDescriptionDayOff(String descriptionDayOff) {
		this.descriptionDayOff = descriptionDayOff;
	}
	public String getMonthYear() {
		return monthYear;
	}
	public void setMonthYear(String monthYear) {
		this.monthYear = monthYear;
	}
	public Date getMondayDate() {
		return mondayDate;
	}
	public void setMondayDate(Date mondayDate) {
		this.mondayDate = mondayDate;
	}
	public String getDescriptionWeekEnd() {
		return descriptionWeekEnd;
	}
	public void setDescriptionWeekEnd(String descriptionWeekEnd) {
		this.descriptionWeekEnd = descriptionWeekEnd;
	}
	public Date getStartFrom() {
		return startFrom;
	}
	public void setStartFrom(Date startFrom) {
		this.startFrom = startFrom;
	}
	public String getWeekEnd() {
		return weekEnd;
	}
	public void setWeekEnd(String weekEnd) {
		this.weekEnd = weekEnd;
	}

	public String getSubstituteHead() {
		return substituteHead;
	}

	public void setSubstituteHead(String substituteHead) {
		this.substituteHead = substituteHead;
	}

	public String getTreeId() {
		return treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public Integer getManagerDivisionId() {
		return managerDivisionId;
	}

	public void setManagerDivisionId(Integer managerDivisionId) {
		this.managerDivisionId = managerDivisionId;
	}

	public Date getMaxStartFrom() {
		return maxStartFrom;
	}

	public void setMaxStartFrom(Date maxStartFrom) {
		this.maxStartFrom = maxStartFrom;
	}

	public byte[] getFilePic() {
		return filePic;
	}

	public void setFilePic(byte[] filePic) {
		this.filePic = filePic;
		
		StringBuilder tmpSb = new StringBuilder();
		tmpSb.append(StringUtils.newStringUtf8(Base64.encodeBase64(filePic, false)));
		this.filePicConverted = tmpSb.toString();
	}
	
	public String getConvertedFilePic(){
		return this.filePicConverted;
	}

	public String getStartMondayDate() {
		return startMondayDate;
	}

	public void setStartMondayDate(String startMondayDate) {
		this.startMondayDate = startMondayDate;
	}
}

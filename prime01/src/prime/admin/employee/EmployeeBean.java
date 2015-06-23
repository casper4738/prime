package prime.admin.employee;

public class EmployeeBean {
	private Integer employeeId;
	private Integer gender = 0;
	private Integer divisionId = 0;
	private Integer positionId = 0;
	/*private Integer employeeLevel = 0;*/
	private Integer managerId = 0;
	private String contactNumber;
	private String employeeName;
	private String address;
	private String email;
	private String divisionName;
	private String positionName;
	private String managerName;
	private String employeeStatus;
	private String resignNote;
	private String birthdate;
	private String resignDate;
	private String hireDate;
	
	public Integer getEmployeeId() {
		System.out.println(employeeId+" EmpId");
		return employeeId;
	}
	public void setEmployeeId(Integer employeeId) {
		this.employeeId = employeeId;
	}
	public Integer getGender() {
		System.out.println(gender+" Gender");
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	public Integer getDivisionId() {
		System.out.println(divisionId+" divId");
		return divisionId;
	}
	public void setDivisionId(Integer divisionId) {
		this.divisionId = divisionId;
	}
	public Integer getPositionId() {
		System.out.println(positionId+" positionId");
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	/*public Integer getEmployeeLevel() {
		return employeeLevel;
	}
	public void setEmployeeLevel(Integer employeeLevel) {
		this.employeeLevel = employeeLevel;
	}*/
	public Integer getManagerId() {
		System.out.println(managerId+" ManId");
		return managerId;
	}
	public void setManagerId(Integer managerId) {
		this.managerId = managerId;
	}
	public String getContactNumber() {
		System.out.println(contactNumber+" contactNumber");
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getEmployeeName() {
		System.out.println(employeeName+" employeeName");
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getAddress() {
		System.out.println(address+" address");
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		System.out.println(email+" email");
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDivisionName() {
		System.out.println(divisionName+" divisionName");
		return divisionName;
	}
	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}
	public String getPositionName() {
		System.out.println(divisionName+" divisionName");
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getManagerName() {
		System.out.println(divisionName+" divisionName");
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getEmployeeStatus() {
		System.out.println(divisionName+" divisionName");
		return employeeStatus;
	}
	public void setEmployeeStatus(String employeeStatus) {
		this.employeeStatus = employeeStatus;
	}
	public String getResignNote() {
		System.out.println(divisionName+" divisionName");
		return resignNote;
	}
	public void setResignNote(String resignNote) {
		this.resignNote = resignNote;
	}
	public String getBirthdate() {
		System.out.println(divisionName+" divisionName");
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getResignDate() {
		System.out.println(divisionName+" divisionName");
		return resignDate;
	}
	public void setResignDate(String resignDate) {
		this.resignDate = resignDate;
	}
	public String getHireDate() {
		System.out.println(hireDate+" hireDate");
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

}

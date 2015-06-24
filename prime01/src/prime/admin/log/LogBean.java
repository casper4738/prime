package prime.admin.log;

import java.sql.Date;

public class LogBean {
private Integer auditTrailId;
private String username;
private  Date auditTrailTime ;
private  Integer auditTrailTable ;
private  String auditTrailAction ;
private  String auditTrailValue ;
public Integer getAuditTrailId() {
	return auditTrailId;
}
public void setAuditTrailId(Integer auditTrailId) {
	this.auditTrailId = auditTrailId;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public Date getAuditTrailTime() {
	return auditTrailTime;
}
public void setAuditTrailTime(Date auditTrailTime) {
	this.auditTrailTime = auditTrailTime;
}
public Integer getAuditTrailTable() {
	return auditTrailTable;
}
public void setAuditTrailTable(Integer auditTrailTable) {
	this.auditTrailTable = auditTrailTable;
}
public String getAuditTrailAction() {
	return auditTrailAction;
}
public void setAuditTrailAction(String auditTrailAction) {
	this.auditTrailAction = auditTrailAction;
}
public String getAuditTrailValue() {
	return auditTrailValue;
}
public void setAuditTrailValue(String auditTrailValue) {
	this.auditTrailValue = auditTrailValue;
}

}

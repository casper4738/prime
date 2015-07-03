package prime.user.notification;

public class NotificationBean  {
private Integer notificationId;
private Integer sender;
private Integer receiver;
private Integer notificationStatus; //read and sent
private Integer notificationType;
private java.util.Date notificationSendDate;
private String notificationNote;
private Integer notificationTemplateId;
private String updatedBy;
private String senderName;
private String receiverName;
private String notificationNameType;
private String notificationLink;

public Integer getNotificationId() {
	return notificationId;
}
public void setNotificationId(Integer notificationId) {
	this.notificationId = notificationId;
}
public Integer getSender() {
	return sender;
}
public void setSender(Integer sender) {
	this.sender = sender;
}
public Integer getReceiver() {
	return receiver;
}
public void setReceiver(Integer receiver) {
	this.receiver = receiver;
}
public Integer getNotificationStatus() {
	return notificationStatus;
}
public void setNotificationStatus(Integer notificationStatus) {
	this.notificationStatus = notificationStatus;
}
public Integer getNotificationType() {
	return notificationType;
}
public void setNotificationType(Integer notificationType) {
	this.notificationType = notificationType;
}
public java.util.Date getNotificationSendDate() {
	return notificationSendDate;
}
public void setNotificationSendDate(java.util.Date notificationSendDate) {
	this.notificationSendDate = notificationSendDate;
}
public String getNotificationNote() {
	return notificationNote;
}
public void setNotificationNote(String notificationNote) {
	this.notificationNote = notificationNote;
}
public Integer getNotificationTemplateId() {
	return notificationTemplateId;
}
public void setNotificationTemplateId(Integer notificationTemplateId) {
	this.notificationTemplateId = notificationTemplateId;
}
public String getUpdatedBy() {
	return updatedBy;
}
public void setUpdatedBy(String updatedBy) {
	this.updatedBy = updatedBy;
}
public String getSenderName() {
	return senderName;
}
public void setSenderName(String senderName) {
	this.senderName = senderName;
}
public String getReceiverName() {
	return receiverName;
}
public void setReceiverName(String receiverName) {
	this.receiverName = receiverName;
}
public String getNotificationNameType() {
	return notificationNameType;
}
public void setNotificationNameType(String notificationNameType) {
	this.notificationNameType = notificationNameType;
}
public String getNotificationLink() {
	return notificationLink;
}
public void setNotificationLink(String notificationLink) {
	this.notificationLink = notificationLink;
}


}

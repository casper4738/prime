<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="resources/prime.js"></script>
</head>
<body>

<html:form action="/SettingAdmin">
	<html:hidden name="SettingAdminForm" property="task"/>
	<html:hidden name="SettingAdminForm" property="message"/>
</html:form>

<logic:equal name="SettingAdminForm" property="task" value="update">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

</body>
</html>
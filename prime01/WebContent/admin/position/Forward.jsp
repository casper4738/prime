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

<html:form action="/PositionAdmin">
	<html:hidden name="PositionAdminForm" property="task"/>
	<html:hidden name="PositionAdminForm" property="message"/>
</html:form>

<logic:equal name="PositionAdminForm" property="task" value="insert">
	<script>flyToForward('success', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="PositionAdminForm" property="task" value="update">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

<logic:equal name="PositionAdminForm" property="task" value="delete">
	<script>flyToForward('success', '<bean:message key="label.message.delete"/>')</script>
</logic:equal>

</body>
</html>
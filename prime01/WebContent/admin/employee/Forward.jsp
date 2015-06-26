<%@page import="prime.constants.Constants"%>
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

<html:form action="/EmployeeAdmin">
	<html:hidden name="EmployeeAdminForm" property="task"/>
	<html:hidden name="EmployeeAdminForm" property="tmpId"/>
	<html:hidden name="EmployeeAdminForm" property="message"/>
</html:form>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOADD%>">
	<script>flyToForward('success', '<bean:message key="label.message.insert"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDIT%>">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DODELETE%>">
	<script>flyToForward('success', '<bean:message key="label.message.delete"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DORESIGN%>">
	<script>flyToForward('success', '<bean:message key="label.message.resign"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DODAYOFF%>">
	<script>flyToForward("<%=Constants.Task.GOTOVIEW%>", '<bean:message key="label.message.dayoff"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDITDAYOFF%>">
	<script>flyToForward("<%=Constants.Task.GOTOVIEW%>", '<bean:message key="label.message.deletedayoff"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOWEEKEND%>">
	<script>flyToForward("<%=Constants.Task.GOTOVIEW%>", '<bean:message key="label.message.weekend"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDITWEEKEND%>">
	<script>flyToForward("<%=Constants.Task.GOTOVIEW%>", '<bean:message key="label.message.deleteweekend"/>')</script>
</logic:equal>

<logic:equal name="EmployeeAdminForm" property="task" value="<%=Constants.Task.DOEDITPOSITION%>">
	<script>flyToForward('success', '<bean:message key="label.message.update"/>')</script>
</logic:equal>
</body>
</html>